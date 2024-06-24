//
//  GameScene.swift
//  DouShouQi
//
//  Created by etudiant on 22/05/2024.
//

import Foundation
import SpriteKit
import DouShouQiModel
import SwiftUI

class GameScene: SKScene {
   
    private var gameVM:GameVM!
    
    private var currentNode: SKNode?
    @Binding var currentPlayer: Player
    @Binding var player1win: Bool
    @Binding var player2win: Bool
    private var moveContinuation: CheckedContinuation<Move, Never>?
    
    private var boardNode:BoardNode!
    
    private var colOrigin:Int!
    private var rowOrigin:Int!
    private var colDest:Int!
    private var rowDest:Int!
    
    private let second: Double = 1000000
    
    init(size:CGSize, gameVM:GameVM, currentPlayer: Binding<Player>, player1win: Binding<Bool>, player2win: Binding<Bool>) {
        self.gameVM = gameVM
        self.gameVM.restartGame()
        
        self._currentPlayer = currentPlayer
        self._player1win = player1win
        self._player2win = player2win
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
        self.backgroundColor = .clear
        
        let ratio = frame.size.width / (SKSpriteNode(imageNamed: "board")).size.width
        
        boardNode = BoardNode(ratio:ratio, position: CGPoint(x: frame.midX, y: frame.midY), nbCols:gameVM.game.board.nbColumns, nbRows: gameVM.game.board.nbRows)
        addChild(boardNode)
        
        setUpBoard(board:gameVM.game.board, ratio: ratio)

        gameVM.game.addGameStartedListener { board in
            self.startText(textValue: "🎉 GO !!! 🎉")
        }
        
        gameVM.game.addInvalidMoveCallbacksListener { _, move, player, result in
            if result {
                self.checkDyingPieces(point: self.boardNode.tileMap.centerOfTile(atColumn: move.columnDestination, row: move.rowDestination), playing: player)
                self.executeMove(move: move, player: player)
                return
            }
            self.forbiddenMoveText()
            self.roleBackMove(move: move, player: player)
        }
        
        gameVM.game.addPlayerNotifiedListener({board, player in
            self.currentPlayer = player

            if player is HumanPlayer {
                Task {
                    let move = await self.awaitPlayerMove()
                    do {
                        try await (player as! HumanPlayer).chooseMove(move)
                    } catch {
                        print("Erreur lors du choix du mouvement: \(error)")
                    }
                }
            } else {
                usleep(useconds_t(0.2 * self.second))
                _ = try! await player.chooseMove(in: board, with: self.gameVM.game.rules)
            }
        })
        
        gameVM.game.addGameOverListener { board, result, player in
            var textResult: String = ""
            switch(result){
            case .notFinished:
                print("⏳ Game is not over yet!")
            case .winner(winner: _, reason: let r):
                print("Game over")
                print(board)
                textResult += "🥇🏆 and the winner is... \(player?.name ?? "")!\n"
                switch(r){
                case .denReached:
                    textResult += "🪺 the opponent's den has been reached."
                case .noMorePieces:
                    textResult += "🐭🐱🐯🦁🐘 all the opponent's animals have been eaten..."
                case .noMovesLeft:
                    textResult += "⛔️ the opponent can not move any piece!"
                case .tooManyOccurences:
                    textResult += "🔄 the opponent seem to like this situation...\n but enough is enough. Sorry..."
                @unknown default:
                    textResult += "no reason :("
                }
                if let p = player {
                    if p.id == self.gameVM.player1.id {
                        self.player1win = true
                    }
                    else {
                        self.player2win = true
                    }
                }
                self.endText(textValue: textResult)
            default:
                break
            }
        }
        
        gameVM.game.addGameChangedListener({ game async in
            //try! await Persistance.saveGame(withName: "game.json", andGame: game)
        })
        if !gameVM.game.isOver {
            Task{
                do{
                    try await gameVM.game.start()
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
        if (!(currentPlayer is HumanPlayer)) {
            return
        }
        
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            
            for node in touchedNodes.reversed() {
                if let nodeName = node.name {
                    if nodeName.contains("Meeple"){
                        self.currentNode = node
                        self.currentNode!.zPosition += 100
                        
                        colOrigin = boardNode.tileMap.tileColumnIndex(fromPosition: node.position)
                        rowOrigin = boardNode.tileMap.tileRowIndex(fromPosition: node.position)
                        
                        colDest = boardNode.tileMap.tileColumnIndex(fromPosition: node.position)
                        rowDest = boardNode.tileMap.tileRowIndex(fromPosition: node.position)
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: node.parent!)
            
            colDest = boardNode.tileMap.tileColumnIndex(fromPosition: touchLocation)
            rowDest = boardNode.tileMap.tileRowIndex(fromPosition: touchLocation)

            node.position = boardNode.tileMap.centerOfTile(atColumn: (colDest > 6 ? 6 : colDest), row: (rowDest > 8 ? 8 : rowDest))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ( colOrigin == colDest && rowOrigin == rowDest) {
            return
        }
        
        let move:Move = Move(of: currentPlayer.id , fromRow: rowOrigin, andFromColumn: colOrigin, toRow: rowDest, andToColumn: colDest)
        
        moveContinuation?.resume(returning: move)
        
        self.currentNode?.zPosition -= 100
    }
    
    private func setUpBoard(board:Board, ratio:CGFloat) {
        for rowIndex in 0...(board.nbRows - 1) {
            for colIndex in 0...(board.nbColumns - 1) {
                if let piece = board.grid[rowIndex][colIndex].piece {
                    boardNode.tileMap.addChild(
                        PiecesNode(ratio: ratio,imageName: piece.animal.imageName, owner: piece.owner, position: boardNode.tileMap.centerOfTile(atColumn: colIndex, row: rowIndex))
                    )
                }
            }
        }
    }
    
    func awaitPlayerMove() async -> Move {
        await withCheckedContinuation { continuation in
            self.moveContinuation = continuation
        }
    }
    
    func executeMove(move:Move, player:Player) {
        
        let originLoc = boardNode.tileMap.centerOfTile(atColumn: move.columnOrigin, row: move.rowOrigin)
        let destLoc = boardNode.tileMap.centerOfTile(atColumn: move.columnDestination, row: move.rowDestination)

        let movedNode = boardNode.tileMap.nodes(at: originLoc)
        
        for node in movedNode.reversed() {
            if let pieceNode: PiecesNode = node as? PiecesNode {
                if let nodeName = pieceNode.name {
                    if nodeName.contains("Meeple") {
                        let col:Int = boardNode.tileMap.tileColumnIndex(fromPosition: destLoc)
                        let row:Int = boardNode.tileMap.tileRowIndex(fromPosition: destLoc)
                        
                        node.position = boardNode.tileMap.centerOfTile(atColumn: (col > 6 ? 6 : col), row: (row > 8 ? 8 : row))
                    }
                }
            }
        }
    }
    
    func roleBackMove(move:Move, player:Player) {
        let originLoc = boardNode.tileMap.centerOfTile(atColumn: move.columnOrigin, row: move.rowOrigin)
        
        let col:Int = boardNode.tileMap.tileColumnIndex(fromPosition: originLoc)
        let row:Int = boardNode.tileMap.tileRowIndex(fromPosition: originLoc)

        if let node = currentNode {
            node.position = boardNode.tileMap.centerOfTile(atColumn: (col > 6 ? 6 : col), row: (row > 8 ? 8 : row))
        }
        
        currentNode = nil
    }
    
    func checkDyingPieces(point:CGPoint, playing: Player) {
        let checkNode = boardNode.tileMap.nodes(at: point)
        
        for node in checkNode.reversed() {
            if let pieceNode: PiecesNode = node as? PiecesNode {
                if let nodeName = pieceNode.name {
                    if nodeName.contains("Meeple")  && pieceNode.getOwner() != playing.id {
                        node.removeFromParent()
                    }
                }
            }
        }
    }
    
    func isMoveValid(move: Move, board: Board) -> Bool {
        return gameVM.game.rules.isMoveValid(onBoard: board, withMove: move)
    }
    
    func startText(textValue: String) {
        self.scene?.isUserInteractionEnabled = false
        let splashText = SKLabelNode(text: textValue)
        splashText.fontName = "AvenirNext-Bold"
        splashText.fontSize = 30
        splashText.fontColor = SKColor.white
        
        let backgroundNode = SKSpriteNode(color: .black , size: boardNode.boardImage.size)
        backgroundNode.alpha = 0.7

        boardNode.addChild(backgroundNode)
        boardNode.addChild(splashText)
        
        let fadeDuration:Double = 1.5
                
        let fadeOutBackground = SKAction.fadeOut(withDuration: fadeDuration)
        let fadeOutText = SKAction.fadeOut(withDuration: fadeDuration)
        
        backgroundNode.run(fadeOutBackground) {
            backgroundNode.removeFromParent()
        }
        
        splashText.run(fadeOutText) {
            splashText.removeFromParent()
        }
        usleep(useconds_t(fadeDuration * self.second))
        self.scene?.isUserInteractionEnabled = true
    }
    
    func endText(textValue: String) {
        let splashText = SKLabelNode(text: textValue)
        splashText.fontName = "AvenirNext-Bold"
        splashText.fontSize = 18
        splashText.fontColor = SKColor.white
        splashText.alpha = 0
        splashText.numberOfLines = 0
        splashText.zPosition = 111
        
        let backgroundNode = SKSpriteNode(color: .black , size: boardNode.boardImage.size)
        backgroundNode.alpha = 0
        backgroundNode.zPosition = 110
        
        let fadeDuration = 1.5
                
        let fadeInBackground = SKAction.fadeAlpha(to: 0.7, duration: fadeDuration)
        let fadeInText = SKAction.fadeIn(withDuration: fadeDuration)
        
        self.boardNode.addChild(backgroundNode)
        self.boardNode.addChild(splashText)
        
        backgroundNode.run(fadeInBackground) {
            backgroundNode.alpha = 0.7
        }
        
        splashText.run(fadeInText) {
            splashText.alpha = 1
        }
        self.scene?.isUserInteractionEnabled = false
    }
    
    func forbiddenMoveText() {
        let forbiddenText = SKLabelNode(text: "Invalid move")
        forbiddenText.fontName = "AvenirNext-Bold"
        forbiddenText.fontSize = 20
        forbiddenText.fontColor = SKColor.white
        forbiddenText.alpha = 0
        forbiddenText.numberOfLines = 0
        forbiddenText.horizontalAlignmentMode = .center
        forbiddenText.verticalAlignmentMode = .center
        
        let fadeDuration = 0.5
        
        let fadeAlpha = SKAction.fadeAlpha(to: 0.5, duration: fadeDuration)
        let fadeOutAction = SKAction.fadeOut(withDuration: fadeDuration)
        
        let backgroundNode = SKSpriteNode(color: .black , size: CGSize(width: 150, height: 50))
        backgroundNode.alpha = 0.5
        
        boardNode.addChild(backgroundNode)
        boardNode.addChild(forbiddenText)

        let sequenceIn = SKAction.sequence([
            fadeAlpha,
            SKAction.wait(forDuration: 0.25),
            fadeOutAction
        ])
        
        let sequenceAlpha = SKAction.sequence([
            fadeAlpha,
            SKAction.wait(forDuration: 0.25),
            fadeOutAction
        ])
            
        forbiddenText.run(sequenceIn) {
            forbiddenText.removeFromParent()
        }
        backgroundNode.run(sequenceAlpha) {
            backgroundNode.removeFromParent()
        }
    }
}

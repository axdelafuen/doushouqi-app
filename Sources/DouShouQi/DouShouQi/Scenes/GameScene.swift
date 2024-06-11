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
    private var currentPlayer: Player!
    private var moveContinuation: CheckedContinuation<Move, Never>?
    
    private var boardNode:BoardNode!
    
    private var colOrigin:Int!
    private var rowOrigin:Int!
    private var colDest:Int!
    private var rowDest:Int!
    
    init(size:CGSize, gameVM:GameVM) {
        self.gameVM = gameVM
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
        
        gameVM.game.addBoardChangedListener({board in
            print(board)
        })
        
        gameVM.game.addMoveChosenCallbacksListener({ board, move, player in
            self.executeMove(move: move, player: player)
        })
        
        gameVM.game.addGameStartedListener {
            print($0)
            print("**************************************")
            print("     ==>> 🎉 GAME STARTS! 🎉 <<==     ")
            print("**************************************")
        }
        
        gameVM.game.addPlayerNotifiedListener({board, player in
            self.currentPlayer = player

            if player is HumanPlayer {
                Task {
                    let move = await self.awaitPlayerMove()
                    print("DEBUG 1 : ",move)
                    do {
                        try await (player as! HumanPlayer).chooseMove(move)
                    } catch {
                        print("Erreur lors du choix du mouvement: \(error)")
                    }
                }
            } else {
                _ = try! await player.chooseMove(in: board, with: self.gameVM.game.rules)
            }
        })
        
        gameVM.game.addGameOverListener { board, result, player in
            switch(result){
            case .notFinished:
                print("⏳ Game is not over yet!")
            case .winner(winner: let o, reason: let r):
                print(board)
                print("**************************************")
                print("Game Over!!!")
                print("🥇🏆 and the winner is... \(o == .player1 ? "🟡" : "🔴") \(player?.name ?? "")!")
                switch(r){
                case .denReached:
                    print("🪺 the opponent's den has been reached.")
                case .noMorePieces:
                    print("🐭🐱🐯🦁🐘 all the opponent's animals have been eaten...")
                case .noMovesLeft:
                    print("⛔️ the opponent can not move any piece!")
                case .tooManyOccurences:
                    print("🔄 the opponent seem to like this situation... but enough is enough. Sorry...")
                }
                print("**************************************")
            default:
                break
            }
        }
        
        Task{
            do{
                try await gameVM.game.start()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
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
        let move:Move = Move(of: currentPlayer.id , fromRow: rowOrigin, andFromColumn: colOrigin, toRow: rowDest, andToColumn: colDest)
        
        if isMoveValid(move: move, board: gameVM.game.board) {
            print("move: OK")
            moveContinuation?.resume(returning: move)
        }else{
            print("move: FAILED")
            //show bad move
            roleBackMove(move: move, player: currentPlayer)
        }
        
        self.currentNode?.zPosition -= 100
    }
    
    private func setUpBoard(board:Board, ratio:CGFloat) {
        for rowIndex in 0...(board.nbRows - 1) {
            for colIndex in 0...(board.nbColumns - 1) {
                if let piece = board.grid[rowIndex][colIndex].piece {
                    boardNode.tileMap.addChild(
                        PiecesNode(ratio: ratio,imageName: piece.animal.imageName, color: piece.owner.color, position: boardNode.tileMap.centerOfTile(atColumn: colIndex, row: rowIndex))
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
                    if nodeName.contains("Meeple"){
                        let col:Int = boardNode.tileMap.tileColumnIndex(fromPosition: destLoc)
                        let row:Int = boardNode.tileMap.tileRowIndex(fromPosition: destLoc)
                        
                        checkDyingPieces(point: destLoc)
                        
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
    
    func checkDyingPieces(point:CGPoint) {
        let checkNode = boardNode.tileMap.nodes(at: point)
        
        for node in checkNode.reversed() {
            if let pieceNode: PiecesNode = node as? PiecesNode {
                if let nodeName = pieceNode.name {
                    if nodeName.contains("Meeple"){
                        node.removeFromParent()
                    }
                }
            }
        }
    }
    
    func isMoveValid(move: Move, board: Board) -> Bool {
        return gameVM.game.rules.isMoveValid(onBoard: board, withMove: move)
    }
}

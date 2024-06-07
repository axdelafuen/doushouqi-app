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
    
    @ObservedObject private var gameVM:GameVM = GameVM()
    private var currentNode: SKNode?
    private var boardNode:BoardNode!
            
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
        self.backgroundColor = .clear
        
        let ratio = frame.size.width / (SKSpriteNode(imageNamed: "board")).size.width
        
        boardNode = BoardNode(ratio:ratio, position: CGPoint(x: frame.midX, y: frame.midY), nbCols:gameVM.game.board.nbColumns, nbRows: gameVM.game.board.nbRows)
        addChild(boardNode)
        
        setUpBoard(board:gameVM.game.board, ratio: ratio)
        
        /*
        for player in gameVM.game.players {
            player.value.addPlayedCallbacksListener{move, player in
                if let m = move {
                    self.executeMove(move: m)
                }
            }
        }
         */
        
        
        gameVM.game.addBoardChangedListener({board in
            print(board)
            //self.updateBoard(board:board, ratio:ratio)
        })
        
        gameVM.game.addMoveChosenCallbacksListener({ board, move, player in
            self.executeMove(move: move)
        })
        
        gameVM.game.addGameStartedListener {
            print($0)
            print("**************************************")
            print("     ==>> 🎉 GAME STARTS! 🎉 <<==     ")
            print("**************************************")
        }
        
        gameVM.game.addPlayerNotifiedListener({board, player in
            _ = try! await player.chooseMove(in: board, with: self.gameVM.game.rules)
        })
        
        gameVM.game.addInvalidMoveCallbacksListener { _, move, player, result in
            if result {
                return
            }
            print("**************************************")
            print("⚠️⚠️⚠️⚠️ Invalid Move detected: \(move) by \(player.name) (\(player.id))")
            print("**************************************")
        }
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
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            
            for node in touchedNodes.reversed() {
                if let nodeName = node.name {
                    if nodeName.contains("Meeple"){
                        self.currentNode = node
                        self.currentNode!.zPosition += 100
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: node.parent!)
            
            let col:Int = boardNode.tileMap.tileColumnIndex(fromPosition: touchLocation)
            let row:Int = boardNode.tileMap.tileRowIndex(fromPosition: touchLocation)
            
            node.position = boardNode.tileMap.centerOfTile(atColumn: (col > 6 ? 6 : col), row: (row > 8 ? 8 : row))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode?.zPosition -= 100
        self.currentNode = nil
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
    
    func executeMove(move:Move) {
        
        let originLoc = boardNode.tileMap.centerOfTile(atColumn: move.columnOrigin, row: move.rowOrigin)
        let destLoc = boardNode.tileMap.centerOfTile(atColumn: move.columnDestination, row: move.rowDestination)
       
        let movedNode = boardNode.tileMap.nodes(at: originLoc)
                
        for node in movedNode.reversed() {
            if let nodeName = node.name {
                if nodeName.contains("Meeple"){
                    let col:Int = boardNode.tileMap.tileColumnIndex(fromPosition: destLoc)
                    let row:Int = boardNode.tileMap.tileRowIndex(fromPosition: destLoc)

                    node.position = boardNode.tileMap.centerOfTile(atColumn: (col > 6 ? 6 : col), row: (row > 8 ? 8 : row))
                }
            }
        }
    }
    
    func updateBoard(board:Board, ratio:CGFloat) {
        for node in boardNode.tileMap.children {
            node.removeFromParent()
        }
        
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
}

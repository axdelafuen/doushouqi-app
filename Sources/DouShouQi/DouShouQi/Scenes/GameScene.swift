//
//  GameScene.swift
//  DouShouQi
//
//  Created by etudiant on 22/05/2024.
//

import Foundation
import SpriteKit
import DouShouQiModel

class GameScene: SKScene {
        
    private var currentNode: SKNode?
    private var boardNode:BoardNode!
    
    private var game:GameVM!
    
    init(size: CGSize, game:GameVM) {
        super.init(size: size)
        
        self.scaleMode = .aspectFill
        self.backgroundColor = .clear
        self.game = game
        
        let ratio = frame.size.width / (SKSpriteNode(imageNamed: "board")).size.width
        
        boardNode = BoardNode(ratio:ratio, position: CGPoint(x: frame.midX, y: frame.midY), game:self.game.game )
        addChild(boardNode)
        
        for rowIndex in 0...(game.game.board.grid.count-1) {
            for colIndex in 0...(game.game.board.grid[0].count-1) {
                if let piece = game.game.board.grid[rowIndex][colIndex].piece {
                    boardNode.tileMap.addChild(
                        PiecesNode(animal: piece.animal, ratio: ratio, color: piece.owner.color, position: boardNode.tileMap.centerOfTile(atColumn: colIndex, row: rowIndex), player:piece.owner)
                    )
                }
            }
        }
    }
    
    /*
     
     let originLoc = self.boardNode.tileMap.centerOfTile(atColumn: move.columnOrigin, row: move.columnDestination)
     let destLoc = self.boardNode.tileMap.centerOfTile(atColumn: move.columnDestination, row: move.rowDestination)
     
     let movedNode = self.nodes(at: originLoc)
     
     for node in movedNode.reversed() {
         if let nodeName = node.name {
             if nodeName.contains("Meeple"){
                 let col:Int = self.boardNode.tileMap.tileColumnIndex(fromPosition: destLoc)
                 let row:Int = self.boardNode.tileMap.tileRowIndex(fromPosition: destLoc)
                 
                 node.position = self.boardNode.tileMap.centerOfTile(atColumn: (col > 6 ? 6 : col), row: (row > 8 ? 8 : row))
             }
         }
     }
     */
            
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
}

//
//  GameScene.swift
//  DouShouQi
//
//  Created by etudiant on 22/05/2024.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
        
    private var currentNode: SKNode?
    private var boardNode:BoardNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.scaleMode = .aspectFill
        self.backgroundColor = .clear

        let ratio = frame.size.width / (SKSpriteNode(imageNamed: "doushouqi_board")).size.width
        
        boardNode = BoardNode(ratio:ratio, position: CGPoint(x: frame.midX, y: frame.midY))
        addChild(boardNode)
        
        let cat = PiecesNode(imageName: "catMeeple", ratio: ratio, color: .cyan, position: boardNode.tileMap.centerOfTile(atColumn: 0, row: 0))
        
        boardNode.tileMap.addChild(cat)
        
        let tiger = PiecesNode(imageName: "tigerMeeple", ratio: ratio, color: .yellow, position: boardNode.tileMap.centerOfTile(atColumn: 6, row: 8))
        
        boardNode.tileMap.addChild(tiger)
    }
    
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
            node.position = boardNode.tileMap.centerOfTile(atColumn: boardNode.tileMap.tileColumnIndex(fromPosition: touchLocation), row: boardNode.tileMap.tileRowIndex(fromPosition: touchLocation))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode?.zPosition -= 100
        self.currentNode = nil
    }
}

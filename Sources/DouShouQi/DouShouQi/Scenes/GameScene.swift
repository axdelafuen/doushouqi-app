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
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.scaleMode = .aspectFill
        self.backgroundColor = .white
        
        let ratio = frame.size.width / (SKSpriteNode(imageNamed: "doushouqi_board")).size.width
        
        let boardNode: BoardNode = BoardNode(ratio:ratio, position: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2))
        addChild(boardNode)
        
        let cat = PiecesNode(imageName: "catMeeple", ratio: ratio, color: .cyan, position: CGPoint(x:(frame.size.width / 2), y: (frame.size.height / 2)))
        addChild(cat)
        
        let tiger = PiecesNode(imageName: "tigerMeeple", ratio: ratio, color: .yellow, position:CGPoint(x: (frame.size.width / 2) + 180, y: (frame.size.height / 2) + 240))
        addChild(tiger)
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
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
}

//
//  GameScene.swift
//  DouShouQi
//
//  Created by etudiant on 22/05/2024.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
        
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = .clear
        
        let board:SKSpriteNode = SKSpriteNode(imageNamed: "doushouqi_board")
        board.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        board.size = CGSize(width: self.size.width, height: self.size.height)
        
        addChild(board)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

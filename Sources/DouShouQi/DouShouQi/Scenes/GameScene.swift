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
        
        self.scaleMode = .aspectFill
        self.backgroundColor = .white
        
        let board:SKSpriteNode = SKSpriteNode(imageNamed: "doushouqi_board")
        board.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let ratio = frame.size.width / board.size.width
        board.size.width = board.size.width * ratio
        board.size.height = board.size.height * ratio

        addChild(board)
        
        let cat:SKSpriteNode = SKSpriteNode(imageNamed: "catMeeple")
        cat.zPosition = 1
        cat.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        cat.size.width = 60 * ratio
        cat.size.height = 60 * ratio
        addChild(cat)
        
        let tiger:SKSpriteNode = SKSpriteNode(imageNamed: "tigerMeeple")
        tiger.zPosition = 1
        tiger.position = CGPoint(x: (frame.size.width / 2) + 180, y: (frame.size.height / 2) + 240)
        tiger.size.width = 60 * ratio
        tiger.size.height = 60 * ratio
        addChild(tiger)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

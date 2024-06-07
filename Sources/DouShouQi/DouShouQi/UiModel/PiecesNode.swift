//
//  PiecesNode.swift
//  DouShouQi
//
//  Created by etudiant on 27/05/2024.
//

import Foundation
import SpriteKit
import DouShouQiModel

class PiecesNode : SKNode {
    
    public var animal:Animal!
    public var player:Owner!
    
    public var imageNode:SKSpriteNode = SKSpriteNode()
    private var colorNode:SKShapeNode = SKShapeNode()
    
    init(animal:Animal, ratio:CGFloat, color:UIColor, position:CGPoint, player:Owner) {
        super.init()

        self.position = position
        self.animal = animal
        self.player = player
        self.name = animal.imageName
        
        imageNode = SKSpriteNode(imageNamed: animal.imageName)
        imageNode.size.width = imageNode.size.width * ratio
        imageNode.size.height = imageNode.size.height * ratio
        
        colorNode = SKShapeNode(ellipseOf: CGSize(width: imageNode.size.width, height: imageNode.size.height))
        colorNode.fillColor = player.color
        
        addChild(colorNode)
        addChild(imageNode)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

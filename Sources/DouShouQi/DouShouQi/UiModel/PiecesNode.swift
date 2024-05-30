//
//  PiecesNode.swift
//  DouShouQi
//
//  Created by etudiant on 27/05/2024.
//

import Foundation
import SpriteKit

class PiecesNode : SKNode {
    
    public var imageNode:SKSpriteNode = SKSpriteNode()
    private var colorNode:SKShapeNode = SKShapeNode()
    
    init(imageName:String, ratio:CGFloat, color:UIColor, position:CGPoint) {
        super.init()

        self.position = position
        self.name = imageName
        
        imageNode = SKSpriteNode(imageNamed: imageName)
        imageNode.size.width = 60 * ratio
        imageNode.size.height = 60 * ratio
        
        colorNode = SKShapeNode(ellipseOf: CGSize(width: imageNode.size.width, height: imageNode.size.height))
        colorNode.fillColor = color
        
        addChild(colorNode)
        addChild(imageNode)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

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
    
    public var imageNode:SKSpriteNode = SKSpriteNode()
    public var colorNode:SKShapeNode = SKShapeNode()
    private let owner:Owner
    
    init(ratio:CGFloat, imageName:String, owner:Owner, position:CGPoint) {
        self.owner = owner
        super.init()

        self.position = position
        self.name = imageName
        
        imageNode = SKSpriteNode(imageNamed: imageName)
        imageNode.size.width = imageNode.size.width * ratio
        imageNode.size.height = imageNode.size.height * ratio
        
        colorNode = SKShapeNode(ellipseOf: CGSize(width: imageNode.size.width, height: imageNode.size.height))
        colorNode.fillColor = owner.color
        
        addChild(colorNode)
        addChild(imageNode)
    }

    func getOwner() -> Owner {
        return owner
    }
    
    required init?(coder aDecoder: NSCoder) {
        owner = .noOne
        super.init(coder: aDecoder)
    }
}

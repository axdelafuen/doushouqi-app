//
//  BoardNode.swift
//  DouShouQi
//
//  Created by etudiant on 27/05/2024.
//

import Foundation
import SpriteKit

class BoardNode : SKNode {
    
    private var boardImage:SKSpriteNode = SKSpriteNode()
    public var tileMap:SKTileMapNode = SKTileMapNode()
    
    init(ratio:CGFloat, position:CGPoint) {
        super.init()
        
        self.position = position
        self.name = "boardNode"
        
        boardImage = SKSpriteNode(imageNamed: "doushouqi_board")
        boardImage.size.width = boardImage.size.width * ratio
        boardImage.size.height = boardImage.size.height * ratio
        
        tileMap = SKTileMapNode(tileSet: SKTileSet(), columns: 7, rows: 9, tileSize: CGSize(width: boardImage.size.width / 7, height: boardImage.size.height / 9))

        addChild(boardImage)
        addChild(tileMap)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

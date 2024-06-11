//
//  BoardNode.swift
//  DouShouQi
//
//  Created by etudiant on 27/05/2024.
//

import Foundation
import SpriteKit

class BoardNode : SKNode {
    
    public var boardImage:SKSpriteNode!
    public var tileMap:SKTileMapNode!
    
    init(ratio:CGFloat, position:CGPoint, nbCols:Int, nbRows:Int) {
        super.init()
        
        self.position = position
        self.name = "boardNode"

        boardImage = SKSpriteNode(imageNamed: "board")
        boardImage.size.width = boardImage.size.width * ratio
        boardImage.size.height = boardImage.size.height * ratio
                
        tileMap = SKTileMapNode(
            tileSet: SKTileSet(),
            columns: nbCols,
            rows: nbRows, 
            tileSize: CGSize(width: ((boardImage.size.width*0.95)/7), height: ((boardImage.size.height*0.96)/9)))
        
        addChild(boardImage)
        addChild(tileMap)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

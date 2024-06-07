//
//  BoardNode.swift
//  DouShouQi
//
//  Created by etudiant on 27/05/2024.
//

import Foundation
import SpriteKit
import DouShouQiModel

class BoardNode : SKNode {
    
    private var boardImage:SKSpriteNode!
    public var tileMap:SKTileMapNode!
    
    init(ratio:CGFloat, position:CGPoint, game:Game) {
        super.init()
        
        self.position = position
        self.name = "boardNode"

        boardImage = SKSpriteNode(imageNamed: "board")
        boardImage.size.width = boardImage.size.width * ratio
        boardImage.size.height = boardImage.size.height * ratio
        
        let tileSet = SKTileSet()
        
        tileMap = SKTileMapNode(tileSet: tileSet, columns: game.board.nbColumns, rows: game.board.nbRows, tileSize: CGSize(width: ((boardImage.size.width*0.95)/7), height: ((boardImage.size.height*0.96)/9)))
        
        addChild(boardImage)
        addChild(tileMap)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

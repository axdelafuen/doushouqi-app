//
//  GameView.swift
//  DouShouQi
//
//  Created by etudiant on 27/05/2024.
//

import SwiftUI
import _SpriteKit_SwiftUI
import DouShouQiModel

struct GamePage: View {
    let player1 = RandomPlayer(withName: "Illidan", andId: .player1)
    let player2 = RandomPlayer(withName: "Sylvanas", andId: .player2)
    
    
    var body: some View {
        SpriteView(scene: GameScene(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)))
            .navigationTitle((player1?.name ?? "Player1" ) + " vs " + (player2?.name ?? "Player2"))
    }
        
}

#Preview {
    GamePage()
}

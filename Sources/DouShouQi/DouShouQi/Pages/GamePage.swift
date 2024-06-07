//
//  GameView.swift
//  DouShouQi
//
//  Created by etudiant on 27/05/2024.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct GamePage: View {
    
    var gameVM: GameVM? = nil
   
    var body: some View {
        SpriteView(scene: GameScene(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)), options: [.allowsTransparency])
            .navigationTitle((self.gameVM?.player1?.name ?? "Player1" ) + " vs " + (self.gameVM?.player2?.name ?? "Player2"))
    }
}
/*
#Preview {
    GamePage()
}
*/

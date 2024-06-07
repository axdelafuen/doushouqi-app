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
    
    @ObservedObject var game: GameVM
    
    init() throws {
        self.game = try GameVM()
    }
    
    var body: some View {
        SpriteView(scene: GameScene(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), game: self.game), options: [.allowsTransparency])
            .navigationTitle((self.game.player1?.name ?? "Player1" ) + " vs " + (self.game.player2?.name ?? "Player2"))
        
        Button(action: {
            Task {
                 try await startGame()
                }
        }){
            Text("test")
        }
    }
   
    func startGame() async throws {
        do{
            try await game.game.start()
        }catch{
            
        }
    }
}
/*
#Preview {
    GamePage()
}
*/

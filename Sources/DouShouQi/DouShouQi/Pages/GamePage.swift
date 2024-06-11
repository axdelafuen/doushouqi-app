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
    
    @StateObject var gameVM: GameVM

    
    init(player1Name: String, player2Name: String) {
        var player1:Player
        var player2:Player
        
        print("p1 name: ", player1Name)
        print("p2 name: ", player2Name)
        
        if player1Name != ""{
            player1 = HumanPlayer(withName: player1Name, andId: .player1)!
        }
        else{
            player1 = RandomPlayer(withName: "Bot1", andId: .player1)!
        }
        if player2Name != "" {
            player2 = HumanPlayer(withName: player2Name, andId: .player2)!
        }
        else{
            player2 = RandomPlayer(withName: "Bot2", andId: .player2)!
        }
        
        do {
            let game = try Game(withRules: ClassicRules(), andPlayer1: player1, andPlayer2: player2)
            _gameVM = StateObject(wrappedValue: GameVM(game: game, player1: player1, player2: player2))
        }catch {
            fatalError("ERROR GAME VM CREATION")
        }
    }
    
    var body: some View {
        SpriteView(scene: GameScene(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), gameVM: self.gameVM), options: [.allowsTransparency])
            .navigationTitle(self.gameVM.player1.name + " vs " + self.gameVM.player2.name)
    }
}
/*
#Preview {
    GamePage()
}
*/

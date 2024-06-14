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
    
    @ObservedObject var gameVM: GameVM
    @State private var currentPlayer: Player
    @State private var player1Win: Bool = false
    @State private var player2Win: Bool = false
    
    init(player1Name: String, player2Name: String) {
        var player1:Player
        var player2:Player
        
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
            currentPlayer = player1
            let game = try Game(withRules: ClassicRules(), andPlayer1: player1, andPlayer2: player2)
            _gameVM = ObservedObject(wrappedValue: GameVM(game: game, player1: player1, player2: player2))
        }catch {
            fatalError("ERROR GAME VM CREATION")
        }
    }
    
    var body: some View {
        ZStack{
            VStack {
                LinearGradient(gradient: Gradient( colors: [Color.clear, player1Win ? Color.cyan : Color.yellow, player1Win ? Color.cyan : Color.yellow]), startPoint: .top, endPoint: .bottom)
                    .overlay(
                        VStack{
                            Text(self.gameVM.player2.name)
                                .padding()
                                .font(.largeTitle)
                            Text("It's your turn")
                                .foregroundColor(.gray)
                                .opacity((currentPlayer.id == gameVM.player2.id ) ? 1 : 0)
                        },
                        alignment: .top
                    )
                
                LinearGradient(gradient: Gradient(colors: [Color.clear, player2Win ? Color.yellow : Color.cyan, player2Win ? Color.yellow : Color.cyan]), startPoint: .bottom, endPoint: .top)
                    .overlay(
                        VStack{
                            Text("It's your turn")
                                .foregroundColor(.gray)
                                .opacity((currentPlayer.id == gameVM.player1.id ) ? 1 : 0)
                            Text(self.gameVM.player1.name)
                                .padding()
                                .font(.largeTitle)
                        },
                        alignment: .bottom
                    )
            }
            SpriteView(scene: GameScene(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), gameVM: self.gameVM, currentPlayer: $currentPlayer, player1win: $player1Win, player2win: $player2Win), options: [.allowsTransparency])
        }
    }
}
/*
#Preview {
    GamePage()
}
*/

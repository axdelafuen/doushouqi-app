//
//  GameVM.swift
//  DouShouQi
//
//  Created by etudiant on 30/05/2024.
//

import Foundation
import DouShouQiModel

class GameVM : ObservableObject {
    
    @Published var game:Game!
    
    @Published var player1:Player!
    @Published var player2:Player!
    
    init(game:Game, player1:Player, player2:Player) {
        self.player1 = player1
        self.player2 = player2
        self.game = game
    }
    
    func restartGame() {
        if game.isOver {
            do {
                self.game = try Game(withRules: ClassicRules(), andPlayer1: self.player1, andPlayer2: self.player2)
            }catch{
                print(error)
            }
        }
    }
}

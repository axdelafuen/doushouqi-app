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
    
    let player1:Player!
    let player2:Player!
    
    init(game:Game, player1:Player, player2:Player) {
        self.game = game
        self.player1 = player1
        self.player2 = player2
    }
}

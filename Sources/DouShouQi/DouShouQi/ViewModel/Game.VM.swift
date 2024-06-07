//
//  GameVM.swift
//  DouShouQi
//
//  Created by etudiant on 30/05/2024.
//

import Foundation
import DouShouQiModel

class GameVM : ObservableObject {
    let player1 = RandomPlayer(withName: "Illidan", andId: .player1)
    let player2 = RandomPlayer(withName: "Sylvanas", andId: .player2)
    
    var game:Game
    
    init(game:Game) {
        self.game = game
    }
    
    init() throws {
        self.game = try Game(withRules: ClassicRules(), andPlayer1: player1!, andPlayer2: player2!)
    }
}

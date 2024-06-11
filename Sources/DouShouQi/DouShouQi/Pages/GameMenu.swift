//
//  GameMenu.swift
//  DouShouQi
//
//  Created by etudiant on 07/06/2024.
//

import SwiftUI

struct GameMenu: View {
    @State var player1Name: String = ""
    @State var player2Name: String = ""
    
    var body: some View {
        
        NavigationStack{
            Spacer()
            Spacer()
            
            TextField("Player1 (empty = bot)", text: $player1Name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 35)
                .padding(.vertical, 10)
                
            TextField("Player2 (empty = bot)", text: $player2Name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 35)
                .padding(.vertical, 10)
            
            Spacer()
            
            NavigationLink {
                GamePage(player1Name: $player1Name.wrappedValue, player2Name: $player2Name.wrappedValue)
            } label: {
                Text("Start game")
                    .padding(.horizontal, 35)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
                
            Spacer()
            Spacer()
            Spacer()
        }
        .navigationTitle("Game menu")
    }
}

#Preview {
    GameMenu()
}

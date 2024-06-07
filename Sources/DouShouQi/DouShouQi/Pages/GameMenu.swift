//
//  GameMenu.swift
//  DouShouQi
//
//  Created by etudiant on 07/06/2024.
//

import SwiftUI

struct GameMenu: View {
    var body: some View {
                
        NavigationStack{
            Spacer()
            Text("Game mode:")
                .bold()
                .font(.title)
            Spacer()
            
            NavigationLink {
                GamePage()
            } label: {
                Text("Random vs Random")
                    .padding(.horizontal, 35)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
                
            Spacer()
            
            Spacer()
        }
    }
}

#Preview {
    GameMenu()
}

//
//  RecordedGamePage.swift
//  DouShouQi
//
//  Created by etudiant on 22/05/2024.
//

import SwiftUI
import Stub

struct RecordedGamesPage: View {
    let records = Stub.gamesRecorded
    
    var body: some View {
        List{
            ForEach(records){ record in
                VStack(alignment: .leading, spacing: 10){
                    Text("\(record.player1.name) vs \(record.player2.name)")
                        .fontWeight(.semibold)
                    
                    switch(record.gameResult) {
                    case .winner(winner: let w, reason: _):
                        if w == record.player1.id {
                            Text("\(record.player1.name) win")
                        }else{
                            Text("\(record.player2.name) win")
                        }
                    default:
                        Text("ERROR")
                    }
                    
                    
                }
            }
        }
        .navigationTitle("Recorded Games")
    }
}

#Preview {
    RecordedGamesPage()
}

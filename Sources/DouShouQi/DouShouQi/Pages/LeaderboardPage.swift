//
//  LeaderboardPage.swift
//  DouShouQi
//
//  Created by etudiant on 22/05/2024.
//

import SwiftUI
import Stub

struct LeaderboardPage: View {
    var body: some View {
        let stats = Stub.gamesLeaderboard
        var rank: Int = 1
        List{
            ForEach(stats) { stat in
                HStack{
                    Text("#\(rank)")
                        .font(.title3)
                    Image("catMeeple")
                    VStack(alignment: .leading){
                        Text("\(stat.player.name)")
                        HStack{
                            Text("\(stat.wins) wins / \(stat.lost) lost")
                        }
                    }
                }
                //rank = rank + 1
            }
        }
        .navigationTitle("Leaderboard")
    }
}

#Preview {
    LeaderboardPage()
}

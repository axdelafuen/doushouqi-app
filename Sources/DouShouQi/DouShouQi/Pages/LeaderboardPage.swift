//
//  LeaderboardPage.swift
//  DouShouQi
//
//  Created by etudiant on 22/05/2024.
//

import SwiftUI

struct LeaderboardPage: View {
    var body: some View {
        
        List{
            HStack{
                Text("#1")
                    .font(.title3)
                Image("catMeeple")
                VStack(alignment: .leading){
                    Text("Irion")
                    HStack{
                        Text("2 wins / 3 lost")
                    }
                }
            }
            HStack{
                Text("#2")
                    .font(.title3)
                Image("tigerMeeple")
                VStack(alignment: .leading){
                    Text("Sylvanas")
                    HStack{
                        Text("2 wins / 4 lost")
                    }
                }
            }
            HStack{
                Text("#3")
                    .font(.title3)
                Image("lionMeeple")
                VStack(alignment: .leading){
                    Text("Illidan")
                    HStack{
                        Text("1 wins / 5 lost")
                    }
                }
            }
        }
        .navigationTitle("Leaderboard")
    }
}

#Preview {
    LeaderboardPage()
}

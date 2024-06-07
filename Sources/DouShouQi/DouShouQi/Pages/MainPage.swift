//
//  MainPage.swift
//  DouShouQi
//
//  Created by etudiant on 14/05/2024.
//

import SwiftUI
import SpriteKit

struct MainPage: View {
    
    var body: some View {
        NavigationStack{
            Text("DouShouQi")
                .bold()
                .font(.largeTitle)
                .toolbar{
                    NavigationLink(destination: SettingsPage()) {
                        Image(systemName: "gear")
                    }
                }
            Spacer()
            
            NavigationLink {
                GameMenu()
            } label: {
                Text("Play now")
                    .padding(.horizontal, 35)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
                
            Spacer()
            
            NavigationLink {
                LeaderboardPage()
            } label: {
                Text("Leaderboard")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.bordered)
            
            NavigationLink {
                RecordedGamesPage()
            } label: {
                Text("Recorded games")
                    .padding(.horizontal, 5)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.bordered)
            
            Spacer()
        }
    }
}
/*
#Preview {
    MainPage()
}
*/

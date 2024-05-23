//
//  MainPage.swift
//  DouShouQi
//
//  Created by etudiant on 14/05/2024.
//

import SwiftUI
import SpriteKit

struct MainPage: View {
    
    var gameScene:GameScene = GameScene(size: CGSize(width: 960, height: 740))
    
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
                SpriteView(scene: gameScene)
            } label: {
                Text("Play now")
            }
            .buttonStyle(.borderedProminent)
                
            Spacer()
            
            NavigationLink {
                LeaderboardPage()
            } label: {
                Text("Leaderboard")
            }
            .buttonStyle(.bordered)
            
            NavigationLink {
                RecordedGamesPage()
            } label: {
                Text("Recorded games")
            }
            .buttonStyle(.bordered)
            
            Spacer()
        }
    }
}

#Preview {
    MainPage()
}

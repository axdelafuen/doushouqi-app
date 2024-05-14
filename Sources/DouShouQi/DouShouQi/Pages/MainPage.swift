//
//  MainPage.swift
//  DouShouQi
//
//  Created by etudiant on 14/05/2024.
//

import SwiftUI

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
            
            Button("Play now", action: {})
                .buttonStyle(.borderedProminent)
            
            Spacer()
            
            Button("Leaderboard", action: {})
                .buttonStyle(.bordered)
            Button("Recorded games", action: {})
                .buttonStyle(.bordered)
            
            Spacer()
        }
    }
}

#Preview {
    MainPage()
}

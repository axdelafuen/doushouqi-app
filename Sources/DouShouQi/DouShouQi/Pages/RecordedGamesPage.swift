//
//  RecordedGamePage.swift
//  DouShouQi
//
//  Created by etudiant on 22/05/2024.
//

import SwiftUI

struct RecordedGamesPage: View {
    var body: some View {
        List{
            VStack(alignment: .leading, spacing: 10){
                Text("Irion vs Illidan")
                    .fontWeight(.semibold)
                
                Text("Irion wins")
            }
            VStack(alignment: .leading, spacing: 10){
                Text("Sylvanas vs Illidan")
                    .fontWeight(.semibold)
                
                Text("Sylvanas wins")
            }
        }
        .navigationTitle("Recorded Games")
    }
}

#Preview {
    RecordedGamesPage()
}

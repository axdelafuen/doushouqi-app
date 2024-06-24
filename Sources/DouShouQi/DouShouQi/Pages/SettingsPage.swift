//
//  SettingsPage.swift
//  DouShouQi
//
//  Created by etudiant on 14/05/2024.
//

import SwiftUI

struct SettingsPage: View {
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Display")){
                    ThemePicker()
                    
                    LanguagePicker()
                }
            }
            .navigationTitle("Settings")
            Spacer()
        }
    }
}

#Preview {
    SettingsPage()
}

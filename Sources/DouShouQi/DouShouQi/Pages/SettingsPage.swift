//
//  SettingsPage.swift
//  DouShouQi
//
//  Created by etudiant on 14/05/2024.
//

import SwiftUI

struct SettingsPage: View {
    
    @AppStorage("lang") private var lang = "US"
   
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Display")){
                    ThemePicker()
                    
                    Picker("Language", selection: $lang) {
                        ForEach(["US", "FR"], id: \.self) { lang in
                            Text(lang)
                        }
                    }
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

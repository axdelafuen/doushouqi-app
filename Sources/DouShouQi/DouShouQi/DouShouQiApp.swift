//
//  DouShouQiApp.swift
//  DouShouQi
//
//  Created by etudiant on 14/05/2024.
//

import SwiftUI

@main
struct DouShouQiApp: App {
    @AppStorage("selectedTheme") public var selectedTheme: AppTheme = .system
    @AppStorage("selectedLanguage") private var selectedLanguage: AppLanguage = .system
    
    var body: some Scene {
        WindowGroup {
            MainPage()
                .preferredColorScheme(selectedTheme.colorScheme)
                .environment(\.locale, selectedLanguage.locale)
        }
    }
}

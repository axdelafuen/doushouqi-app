//
//  DouShouQiApp.swift
//  DouShouQi
//
//  Created by etudiant on 14/05/2024.
//

import SwiftUI

@main
struct DouShouQiApp: App {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    var body: some Scene {
        WindowGroup {
            MainPage()
                .preferredColorScheme(selectedTheme.colorScheme)
        }
    }
}

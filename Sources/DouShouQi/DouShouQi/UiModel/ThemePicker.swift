//
//  ThemePicker.swift
//  DouShouQi
//
//  Created by etudiant on 14/05/2024.
//

import SwiftUI

struct ThemePicker: View {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    var body: some View {
        Picker("Theme", selection: $selectedTheme) {
            ForEach(AppTheme.allCases) { theme in
                Text(theme.rawValue).tag(theme)
            }
        }
    }
}

#Preview {
    ThemePicker()
}

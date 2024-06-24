//
//  LanguagePicker.swift
//  DouShouQi
//
//  Created by etudiant on 24/06/2024.
//

import Foundation
import SwiftUI

struct LanguagePicker: View {
    @AppStorage("selectedLanguage") private var selectedLanguage: AppLanguage = .system

    var body: some View {
        Picker("Language", selection: $selectedLanguage) {
            ForEach(AppLanguage.allCases) { lang in
                Text(lang.rawValue).tag(lang)
            }
        }
    }
}

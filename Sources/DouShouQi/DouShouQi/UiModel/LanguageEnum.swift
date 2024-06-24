//
//  LanguageEnum.swift
//  DouShouQi
//
//  Created by etudiant on 24/06/2024.
//

import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case system = "System"
    case english = "English"
    case french = "French"
    
    var id: String { self.rawValue }
    
    var locale: Locale {
        switch self {
        case .system:
            return Locale.current
        case .english:
            return Locale(identifier: "en")
        case .french:
            return Locale(identifier: "fr")
        }
    }
}

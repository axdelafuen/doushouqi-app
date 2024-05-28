//
//  Owner.UI.swift
//  DouShouQi
//
//  Created by etudiant on 27/05/2024.
//

import Foundation
import DouShouQiModel

extension Owner {
    public var color: String {
        switch self {
        case .player1:
            return "🟡"
        case .player2:
            return "🔴"
        default:
            return "  "
        }
    }
}


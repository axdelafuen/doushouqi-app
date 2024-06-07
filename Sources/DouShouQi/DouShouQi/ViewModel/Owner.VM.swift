//
//  Owner.UI.swift
//  DouShouQi
//
//  Created by etudiant on 27/05/2024.
//

import Foundation
import DouShouQiModel
import UIKit

extension Owner {
    public var color: UIColor {
        switch self {
        case .player1:
            return .systemCyan
        case .player2:
            return .systemYellow
        default:
            return .clear
        }
    }
}


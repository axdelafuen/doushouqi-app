//
//  Animal.UI.swift
//  DouShouQi
//
//  Created by etudiant on 27/05/2024.
//

import Foundation
import DouShouQiModel

extension Animal {
    public var imageName: String {
        switch self{
        case .rat:
            return "ratMeeple"
        case .cat:
            return "catMeeple"
        case .dog:
            return "dogMeeple"
        case .wolf:
            return "wolfMeeple"
        case .leopard:
            return "leopardMeeple"
        case .tiger:
            return "tigerMeeple"
        case .lion:
            return "lionMeeple"
        case .elephant:
            return "elephantMeeple"
        @unknown default:
            return ""
        }
    }
}

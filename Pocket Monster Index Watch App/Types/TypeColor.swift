//
//  TypeColor.swift
//  The Pocket Monster Index Watch App
//
//  Created by Dakota Kim on 3/31/24.
//

import Foundation
import SwiftUI

enum TypeColor {
    static func color(for type: String) -> Color {
        switch type.lowercased() {
        case "normal":
            return .gray
        case "fire":
            return .red
        case "water":
            return .blue
        case "electric":
            return .yellow
        case "grass":
            return .green
        case "ice":
            return .cyan
        case "fighting":
            return .orange
        case "poison":
            return .purple
        case "ground":
            return .brown
        case "flying":
            return .indigo
        case "psychic":
            return .pink
        case "bug":
            return .mint
        case "rock":
            return .secondary
        case "ghost":
            return .indigo
        case "dragon":
            return .indigo
        case "dark":
            return .black
        case "steel":
            return .gray
        case "fairy":
            return .pink
        default:
            return .primary
        }
    }
}

//
//  Region.swift
//  The Pocket Monster Index Watch App
//
//  Created by Dakota Kim on 3/28/24.
//

import Foundation
import SwiftUI

struct Region: Identifiable {
    let id = UUID()
    let name: String
    let offset: Int
    let limit: Int
    let color: Color
    let icon: String
}

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [RegionPokemon]
}

struct RegionPokemon: Codable, Identifiable {
    var id: Int {
        let components = url.components(separatedBy: "/")
        return Int(components[components.count - 2]) ?? 0
    }
    
    let name: String
    let url: String
    var spriteURL: String?
    
}

//
//  Pokemon.swift
//  The Pocket Monster Index Watch App
//
//  Created by Dakota Kim on 3/28/24.
//

import Foundation

struct Pokemon: Codable {
    let height: Int
    let id: Int
    let isDefault: Bool
    let name: String
    let order: Int
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int
    let sprites: Sprites
    
    var typeDescription: String {
            let typeNames = types.map { $0.type.name.capitalized }
            let typesString = typeNames.joined(separator: "-")
            return "the \(typesString) Pokémon"
        }
    
    var heightInMeters: Double {
            return Double(height) / 10
        }
        
        var weightInKilograms: Double {
            return Double(weight) / 10
        }
}

struct TypeElement: Codable {
    let slot: Int
    let type: TypeType
}

struct TypeType: Codable {
    let name: String
    let url: String
}

struct Stat: Codable {
    let baseStat: Int
    let effort: Int
    let stat: StatStat
}

struct StatStat: Codable {
    let name: String
    let url: String
}

struct Sprites: Codable {
    let frontDefault: String

}

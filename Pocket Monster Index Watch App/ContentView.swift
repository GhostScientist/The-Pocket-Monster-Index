//
//  ContentView.swift
//  The Pocket Monster Index Watch App
//
//  Created by Dakota Kim on 3/28/24.
//

import SwiftUI

struct ContentView: View {
    
    let pokemonAPI = PokemonAPI()
    
    let regions: [Region] = [
        Region(name: "Kanto", offset: 0, limit: 151, color: .red, icon: "🗻"),
        Region(name: "Johto", offset: 151, limit: 100, color: .blue, icon: "🏯"),
        Region(name: "Hoenn", offset: 251, limit: 135, color: .green, icon: "🌋"),
        Region(name: "Sinnoh", offset: 386, limit: 107, color: .purple, icon: "❄️"),
        Region(name: "Unova", offset: 493, limit: 156, color: .orange, icon: "🌇"),
        Region(name: "Kalos", offset: 649, limit: 72, color: .pink, icon: "🗼"),
        Region(name: "Alola", offset: 721, limit: 88, color: .yellow, icon: "🌴"),
        Region(name: "Galar", offset: 809, limit: 89, color: .indigo, icon: "🏰"),
        Region(name: "Hisui", offset: 898, limit: 7, color: .mint, icon: "🍂"),
        Region(name: "Paldea", offset: 905, limit: 103, color: .teal, icon: "🌄")
    ]
    
    var body: some View {
        NavigationView {
            List(regions) { region in
                NavigationLink(destination: PokemonRegionListView(region: region)) {
                    HStack {
                        Text(region.name)
                            .foregroundColor(.white)
                        Spacer()
                        Text(region.icon)
                            .font(.headline)
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    }
                }
            }
            .navigationTitle("Regions")
        }
    }
}


#Preview {
    ContentView()
}


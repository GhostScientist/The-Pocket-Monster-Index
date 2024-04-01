//
//  PokemonRegionListView.swift
//  The Pocket Monster Index Watch App
//
//  Created by Dakota Kim on 3/28/24.
//

import SwiftUI

struct PokemonRowView: View {
    var pokemon: RegionPokemon
    
    var body: some View {
        HStack {
            Text(pokemon.name.capitalized)
            Spacer()
            Image("\(pokemon.id)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
        }
    }
}

struct PokemonRegionListView: View {
    let region: Region
    @State private var pokemonList: [RegionPokemon] = []
    @State private var searchText = ""
    
    var body: some View {
        List {
            ForEach(Array(filterPokemonList(by: searchText).enumerated()), id: \.element.id) { index, pokemon in
                
                NavigationLink {
                    PokemonDetailView(regionPokemon: pokemon)
                } label: {
                    PokemonRowView(pokemon: pokemon)
                }

                
            }
        }
        .conditionalSearchable(searchText: $searchText, forVersionMatching: shouldEnableSearchable())
       
        .navigationTitle(region.name)
        .onAppear {
            fetchPokemonList()
        }
    }
    
    private func shouldEnableSearchable() -> Bool {
           let systemVersion = WKInterfaceDevice.current().systemVersion
           guard let systemVersionDouble = Double(systemVersion) else { return false }

           if systemVersionDouble >= 10.2 && systemVersionDouble <= 10.3 {
               return false
           } else {
               return true
           }
       }
    
    func fetchPokemonList() {
        let urlString = "https://pokeapi.co/api/v2/pokemon?offset=\(region.offset)&limit=\(region.limit)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemonListResponse = try decoder.decode(PokemonListResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.pokemonList = pokemonListResponse.results
                }
            } catch {
                print("Error decoding JSON: \\(error)")
            }
        }.resume()
    }
    
    func filterPokemonList(by searchText: String) -> [RegionPokemon] {
        guard !searchText.isEmpty else {
            return pokemonList
        }
        return pokemonList.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}


extension View {
    func conditionalSearchable(searchText: Binding<String>, forVersionMatching isEnabled: Bool) -> some View {
        self.modifier(ConditionalSearchableModifier(searchText: searchText, isEnabled: isEnabled))
    }
}

struct ConditionalSearchableModifier: ViewModifier {
    @Binding var searchText: String
    let isEnabled: Bool

    func body(content: Content) -> some View {
        if isEnabled {
            content.searchable(text: $searchText)
        } else {
            content
        }
    }
}

#Preview {
    PokemonRegionListView(region: Region(name: "Kanto", offset: 0, limit: 151, color: .yellow, icon: "X"))
}

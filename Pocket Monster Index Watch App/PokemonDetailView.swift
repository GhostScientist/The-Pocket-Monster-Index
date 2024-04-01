//
//  PokemonDetailView.swift
//  The Pocket Monster Index Watch App
//
//  Created by Dakota Kim on 3/31/24.
//

import SwiftUI

import AVFoundation

var audioPlayer: AVAudioPlayer?

struct PokemonDetailView: View {
    var regionPokemon: RegionPokemon
    @State var pokemon: Pokemon?
    @State var isLoading = true
    
    
    let pokemonAPI = PokemonAPI()
    
    var body: some View {
        ScrollView {
            if isLoading {
                VStack {
                    Text("Loading...")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let pokemon = pokemon {
                VStack(alignment: .center) {
                    Image("\(pokemon.id)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .onTapGesture {
                            
                            guard let path = Bundle.main.path(forResource: "\(pokemon.id)", ofType: "mp3") else { print("No file found!")
                                return
                            }
                            let url = URL(fileURLWithPath: path)
                            
                            do {
                                audioPlayer = try AVAudioPlayer(contentsOf: url)
                                audioPlayer?.play()
                            } catch {
                                print("Error loading audio file...")
                            }
                        }
                    
                    
                    VStack(alignment: .leading) {
                        Text("\(pokemon.name.capitalized),")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(pokemon.typeDescription).font(.footnote)
                        
                        Divider()
                        
                        
                        Text("Height: \(String(format: "%.1f", pokemon.heightInMeters)) m")
                        Text("Weight: \(String(format: "%.1f", pokemon.weightInKilograms)) kg")
                        
                        
                        Divider()
                        
                        Text("Types:")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        HStack {
                            ForEach(pokemon.types, id: \.type.name) { type in
                                Text(type.type.name.capitalized)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(TypeColor.color(for: type.type.name))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                        
                        Divider()
                        
                        Text("Stats:")
                            .font(.headline)
                            .fontWeight(.semibold)
                        ForEach(pokemon.stats, id: \.stat.name) { stat in
                            HStack {
                                Text(stat.stat.name.uppercased())
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("\(stat.baseStat)")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.horizontal, 8)
                            
                            Divider()
                        }
                    }
                    
                }
                .padding()
            } else {
                Text("Failed to load Pokemon details.")
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
        .onAppear {
            fetchPokemonDetails()
        }
    }
    
    func fetchPokemonDetails() {
        isLoading = true
        let url = URL(string: regionPokemon.url)!
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                isLoading = false
                return
            }
            
            guard let data = data else {
                print("No data received")
                isLoading = false
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    isLoading = false
                }
            } catch {
                print("Error decoding Pokemon: \(error.localizedDescription)")
                isLoading = false
            }
        }.resume()
    }
}

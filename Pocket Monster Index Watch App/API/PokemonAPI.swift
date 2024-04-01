//
//  PokemonAPI.swift
//  The Pocket Monster Index Watch App
//
//  Created by Dakota Kim on 3/28/24.
//

import Foundation


class PokemonAPI {
    private let baseURL = "https://pokeapi.co/api/v2/"
    
    func fetchPokemon(id: Int, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        let urlString = "\(baseURL)pokemon/\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchPokemon(_ urlString: URL, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        URLSession.shared.dataTask(with: urlString) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
//    func fetchEvolutionChain(url: String, completion: @escaping (Result<EvolutionChain, Error>) -> Void) {
//        
//    }
    
    enum APIError: Error {
        case invalidURL
        case noData
    }
}

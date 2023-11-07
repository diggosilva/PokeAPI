//
//  Service.swift
//  PokeAPI
//
//  Created by Diggo Silva on 07/11/23.
// https://pokeapi.co/api/v2/pokemon?limit=200

import Foundation

struct Service {
    static let shared = Service()
    
    private init() {
        
    }
    
    func getPokeName(completion: @escaping([Result]) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=200") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else { return }
            do {
                let pokeName = try JSONDecoder().decode(PokemonName.self, from: data)
                DispatchQueue.main.async {
                    completion(pokeName.results)
                    print(pokeName)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

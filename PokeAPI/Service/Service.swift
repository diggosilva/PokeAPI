//
//  Service.swift
//  PokeAPI
//
//  Created by Diggo Silva on 07/11/23.
// https://pokeapi.co/api/v2/pokemon?limit=200/

import Foundation

struct Service {
    static let shared = Service()
    
    private init() {
        
    }
    
    func getPokeName(completion: @escaping([Results]) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=200") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else { return }
            do {
                let pokeName = try JSONDecoder().decode(PokeResult.self, from: data)
                DispatchQueue.main.async {
                    completion(pokeName.results)
                }
            } catch {
                print("Erro no NOME: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getPokeImage(name: String, completion: @escaping(String, Int, Int, Int, Int) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else { return }
            do {
                let pokeImage = try JSONDecoder().decode(PokemonSelected.self, from: data)
                DispatchQueue.main.async {
                    completion(pokeImage.sprites.other.officialArtwork.frontDefault, pokeImage.height, pokeImage.weight, pokeImage.baseExperience, pokeImage.id)
                }
            } catch {
                print("Erro na IMAGEM: \(error.localizedDescription)")
            }
        }.resume()
    }
}

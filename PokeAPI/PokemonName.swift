//
//  PokemonName.swift
//  PokeAPI
//
//  Created by Diggo Silva on 07/11/23.
//

import Foundation

struct PokemonName: Codable {
    let results: [Result]
}

struct Result: Codable {
    let name: String
    let url: String
}

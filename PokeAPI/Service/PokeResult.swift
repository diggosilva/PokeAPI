//
//  PokemonName.swift
//  PokeAPI
//
//  Created by Diggo Silva on 07/11/23.
//

import Foundation

struct PokeResult: Codable {
    let results: [Results]
}

struct Results: Codable {
    let name: String
}

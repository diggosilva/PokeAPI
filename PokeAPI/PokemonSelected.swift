//
//  PokemonSelected.swift
//  PokeAPI
//
//  Created by Diggo Silva on 07/11/23.
//

import Foundation

struct PokemonSelected: Codable {
    let sprites: Sprites
}

struct Sprites: Codable {
    let other: Other
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

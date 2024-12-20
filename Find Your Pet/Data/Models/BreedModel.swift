//
//  BreedModel.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Foundation

struct BreedModel: Decodable {
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let lifeSpan: String
    let wikipediaURL: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case temperament
        case origin
        case lifeSpan = "life_span"
        case wikipediaURL = "wikipedia_url"
    }
}

//
//  BreedEntity.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

struct BreedEntity: Identifiable {
    let id: String
    let name: String
    let temperament: String?
    let origin: String?
    let lifeSpan: String?
    let wikipediaURL: String?
}

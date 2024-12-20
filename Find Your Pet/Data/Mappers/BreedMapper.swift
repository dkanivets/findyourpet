//
//  BreedMapper.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import Foundation

struct BreedMapper {
    static func toEntity(from content: BreedModel?) -> BreedEntity? {
        guard let content = content else { return nil }
        return BreedEntity(
            id: content.id,
            name: content.name,
            temperament: content.temperament,
            origin: content.origin,
            lifeSpan: content.lifeSpan,
            wikipediaURL: content.wikipediaURL
        )
    }
    
    static func toModel(from content: BreedEntity?) -> BreedModel? {
        guard let content = content else { return nil }
        return BreedModel(
            id: content.id,
            name: content.name,
            temperament: content.temperament ?? "",
            origin: content.origin ?? "",
            lifeSpan: content.lifeSpan ?? "",
            wikipediaURL: content.wikipediaURL
        )
    }
}

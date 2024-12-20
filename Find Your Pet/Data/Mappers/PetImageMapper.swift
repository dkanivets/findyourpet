//
//  PetImageMapper.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import Foundation

struct PetImageMapper {
    static func toEntity(from content: PetImageModel?) -> PetImageEntity? {
        guard let content = content else { return nil }
        return PetImageEntity(
            id: content.id,
            url: content.url,
            width: content.width,
            height: content.height,
            breeds: content.breeds?.compactMap { BreedMapper.toEntity(from: $0) },
            categories: content.categories?.compactMap { CategoryMapper.toEntity(from: $0) }
        )
    }

    static func toEntity(from content: [PetImageModel]?) -> [PetImageEntity] {
        guard let content = content else { return [] }
        return content.compactMap { toEntity(from: $0) }
    }
    
    static func toModel(from content: PetImageEntity?) -> PetImageModel? {
        guard let content = content else { return nil }
        return PetImageModel(
            id: content.id,
            url: content.url,
            width: content.width,
            height: content.height,
            breeds: content.breeds?.compactMap { BreedMapper.toModel(from: $0) },
            categories: content.categories?.compactMap { CategoryMapper.toModel(from: $0) }
        )
    }
}

//
//  CategoryMapper.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import Foundation

struct CategoryMapper {
    static func toEntity(from content: CategoryModel?) -> CategoryEntity? {
        guard let content = content else { return nil }
        return CategoryEntity(
            id: content.id,
            name: content.name
        )
    }
    
    static func toModel(from content: CategoryEntity?) -> CategoryModel? {
        guard let content = content else { return nil }
        return CategoryModel(
            id: content.id,
            name: content.name
        )
    }
}

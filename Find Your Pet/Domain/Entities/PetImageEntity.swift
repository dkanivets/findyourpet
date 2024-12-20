//
//  PetImageEntity.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import Foundation

struct PetImageEntity: Identifiable {
    let id: String
    let url: String
    let width: Int
    let height: Int
    let breeds: [BreedEntity]?
    let categories: [CategoryEntity]?
}

//
//  PetImageModel.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Foundation

struct PetImageModel: Decodable {
    let id: String
    let url: String
    let width: Int
    let height: Int
//    let breeds: [BreedModel]?
//    let categories: [CategoryModel]?
}

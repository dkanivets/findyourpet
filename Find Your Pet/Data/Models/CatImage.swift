//
//  Cat.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Foundation

struct CatImage: Decodable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}

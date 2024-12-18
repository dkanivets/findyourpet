//
//  CarRepository.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Foundation

protocol CatRepository {
    func fetchCatImages(completion: @escaping (Result<[CatImage], NetworkError>) -> Void)
}

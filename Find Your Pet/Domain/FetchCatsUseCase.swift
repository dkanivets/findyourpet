//
//  FetchCatsUseCase.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Foundation

class FetchCatImagesUseCase {
    private let repository: CatRepository
    
    init(repository: CatRepository) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<[CatImage], NetworkError>) -> Void) {
        repository.fetchCatImages(completion: completion)
    }
}

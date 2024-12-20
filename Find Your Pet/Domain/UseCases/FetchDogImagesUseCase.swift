//
//  FetchDogImagesUseCase.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import Foundation
import Combine

// MARK: - Use Case Protocol

protocol FetchDogImagesUseCase {
    func call(limit: Int, breedID: String?, page: Int?, order: String?) -> AnyPublisher<[PetImageEntity], NetworkError>
}

// MARK: - Use Case Implementation

struct FetchDogImagesUseCaseImpl: FetchDogImagesUseCase {
    var repository: DogsRepository

    func call(limit: Int = 10, breedID: String? = nil, page: Int? = nil, order: String? = "RAND") -> AnyPublisher<[PetImageEntity], NetworkError> {
        repository.getDogImages(limit: limit, breedID: breedID, page: page, order: order)
    }
}

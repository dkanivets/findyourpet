//
//  FetchSingleDogImageUseCase.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import Foundation
import Combine

// MARK: - Use Case Protocol

protocol FetchSingleDogImageUseCase {
    func call(imageID: String) -> AnyPublisher<PetImageEntity, NetworkError>
}

// MARK: - Use Case Implementation

struct FetchSingleDogImageUseCaseImpl: FetchSingleDogImageUseCase {
    var repository: DogsRepository

    func call(imageID: String) -> AnyPublisher<PetImageEntity, NetworkError> {
        repository.getImageByID(imageID: imageID)
    }
}

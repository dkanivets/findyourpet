//
//  FetchSingleCatImageUseCase.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import Foundation
import Combine

// MARK: - Use Case Protocol

protocol FetchSingleCatImageUseCase {
    func call(imageID: String) -> AnyPublisher<PetImageEntity, NetworkError>
}

// MARK: - Use Case Implementation

struct FetchSingleCatImageUseCaseImpl: FetchSingleCatImageUseCase {
    var repository: CatsRepository

    func call(imageID: String) -> AnyPublisher<PetImageEntity, NetworkError> {
        repository.getImageByID(imageID: imageID)
    }
}

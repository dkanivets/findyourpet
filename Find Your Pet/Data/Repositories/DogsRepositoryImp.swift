//
//  DogsRepositoryImp.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import Foundation
import Combine

// MARK: - DogsRepository Implementation
struct DogsRepositoryImp: DogsRepository {
    private let dogsRemoteDataSource: DogsRemoteDataSource

    init(dogsRemoteDataSource: DogsRemoteDataSource) {
        self.dogsRemoteDataSource = dogsRemoteDataSource
    }

    func getDogImages(limit: Int, breedID: String?, page: Int?, order: String?) -> AnyPublisher<[PetImageEntity], NetworkError> {
        return dogsRemoteDataSource
            .getDogImages(limit: limit, breedID: breedID, page: page, order: order)
            .map { PetImageMapper.toEntity(from: $0) }
            .eraseToAnyPublisher()
    }

    func getImageByID(imageID: String) -> AnyPublisher<PetImageEntity, NetworkError> {
        return dogsRemoteDataSource
            .getImageByID(imageID: imageID)
            .tryMap { response in
                guard let entity = PetImageMapper.toEntity(from: response) else {
                    throw NetworkError.decodingFailed
                }
                return entity
            }
            .mapError { error in
                error as? NetworkError ?? .unknown(error)
            }
            .eraseToAnyPublisher()
    }
}

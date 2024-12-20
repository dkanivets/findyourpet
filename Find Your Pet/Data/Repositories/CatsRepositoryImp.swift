//
//  CatsRepositoryImp.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Foundation
import Combine

// MARK: - CatsRepository Implementation

struct CatsRepositoryImp: CatsRepository {
    private let catsRemoteDataSource: CatsRemoteDataSource

    init(catsRemoteDataSource: CatsRemoteDataSource) {
        self.catsRemoteDataSource = catsRemoteDataSource
    }

    func getCatImages(limit: Int, breedID: String?, page: Int?, order: String?) -> AnyPublisher<[PetImageEntity], NetworkError> {
        return catsRemoteDataSource
            .getCatImages(limit: limit, breedID: breedID, page: page, order: order)
            .map { response in PetImageMapper.toEntity(from: response) }
            .eraseToAnyPublisher()
    }

    func getImageByID(imageID: String) -> AnyPublisher<PetImageEntity, NetworkError> {
        return catsRemoteDataSource
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

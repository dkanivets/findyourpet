//
//  DogsRepository.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import Foundation
import Combine

// MARK: - DogsRepository Protocol
protocol DogsRepository {
    func getDogImages(limit: Int, breedID: String?, page: Int?, order: String?) -> AnyPublisher<[PetImageEntity], NetworkError>
    func getImageByID(imageID: String) -> AnyPublisher<PetImageEntity, NetworkError>
}

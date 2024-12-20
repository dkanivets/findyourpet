//
//  CatsRepository.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Foundation
import Combine

protocol CatsRepository {
    func getCatImages(limit: Int, breedID: String?, page: Int?, order: String?) -> AnyPublisher<[PetImageEntity], NetworkError>
    func getImageByID(imageID: String) -> AnyPublisher<PetImageEntity, NetworkError>
}

//
//  MockCatsRepository.swift
//  Find Your PetTests
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import XCTest
import Combine
@testable import Find_Your_Pet

class MockCatsRepository: CatsRepository {
    var result: Result<[PetImageEntity], NetworkError>?
    var singleImageResult: Result<PetImageEntity, NetworkError>?

    func getCatImages(limit: Int, breedID: String?, page: Int?, order: String?) -> AnyPublisher<[PetImageEntity], NetworkError> {
        if let result = result {
            return Future { promise in
                promise(result)
            }
            .eraseToAnyPublisher()
        } else {
            return Fail(error: .unknown(NSError(domain: "NoResult", code: -1, userInfo: nil)))
                .eraseToAnyPublisher()
        }
    }

    func getImageByID(imageID: String) -> AnyPublisher<PetImageEntity, NetworkError> {
        if let singleImageResult = singleImageResult {
            return Future { promise in
                promise(singleImageResult)
            }
            .eraseToAnyPublisher()
        } else {
            return Fail(error: .unknown(NSError(domain: "NoResult", code: -1, userInfo: nil)))
                .eraseToAnyPublisher()
        }
    }
}

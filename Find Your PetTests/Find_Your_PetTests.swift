//
//  Find_Your_PetTests.swift
//  Find Your PetTests
//
//  Created by Dmitry Kanivets on 17.12.2024.
//

import XCTest
import Combine
@testable import Find_Your_Pet

class FetchCatImagesUseCaseTests: XCTestCase {
    var sut: FetchCatImagesUseCaseImpl!
    var mockRepository: MockCatsRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockCatsRepository()
        sut = FetchCatImagesUseCaseImpl(repository: mockRepository)
        cancellables = []
    }

    override func tearDown() {
        mockRepository = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchCatImagesSuccess() {
        let expectedImages: [PetImageEntity] = [
            PetImageEntity(id: "1", url: "url1", width: 200, height: 200),
            PetImageEntity(id: "2", url: "url2", width: 300, height: 300)
        ]
        mockRepository.result = .success(expectedImages)

        let expectation = self.expectation(description: "FetchCatImages succeeds")
        var receivedImages: [PetImageEntity]?

        sut.call(limit: 10, breedID: nil, page: 1, order: "ASC")
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Expected success, got failure")
                }
            } receiveValue: { images in
                receivedImages = images
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(receivedImages, expectedImages, "Fetched images do not match expected images")
    }

    func testFetchCatImagesFailure() {
        mockRepository.result = .failure(.requestFailed)

        let expectation = self.expectation(description: "FetchCatImages fails")
        var receivedError: NetworkError?

        sut.call(limit: 10, breedID: nil, page: 1, order: "ASC")
            .sink { completion in
                if case let .failure(error) = completion {
                    receivedError = error
                    expectation.fulfill()
                }
            } receiveValue: { _ in
                XCTFail("Expected failure, got success")
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(receivedError, .requestFailed, "Expected requestFailed error but got something else")
    }
}

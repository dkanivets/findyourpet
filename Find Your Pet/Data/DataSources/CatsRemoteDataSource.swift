//
//  CatsRemoteDataSource.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Foundation
import Combine

// MARK: - CatRemoteRepository Protocol

protocol CatRemoteRepository {
    func getBreeds() -> AnyPublisher<[Breed], NetworkError>
    func getCatImages(breedID: String, limit: Int) -> AnyPublisher<[CatImage], NetworkError>
    func getCategories() -> AnyPublisher<[Category], NetworkError>
    func searchImages(searchText: String, page: Int, limit: Int) -> AnyPublisher<[CatImage], NetworkError>
}

// MARK: - Implementation

class CatRemoteRepositoryImpl: CatRemoteRepository {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getBreeds() -> AnyPublisher<[Breed], NetworkError> {
        apiService.call(method: .get,
                        apiUrl: .parent("/breeds"),
                        type: [Breed].self,
                        body: nil,
                        headers: ["x-api-key": ApiKeys.catApiKey],
                        query: nil,
                        decoder: nil)
    }
    
    func getCatImages(breedID: String, limit: Int) -> AnyPublisher<[CatImage], NetworkError> {
        apiService.call(method: .get,
                        apiUrl: .parent("/images/search"),
                        type: [CatImage].self,
                        body: nil,
                        headers: ["x-api-key": ApiKeys.catApiKey],
                        query: ["breed_ids": breedID,
                                "limit": limit],
                        decoder: nil)
    }
    
    func getCategories() -> AnyPublisher<[Category], NetworkError> {
        apiService.call(method: .get,
                        apiUrl: .parent("/categories"),
                        type: [Category].self,
                        body: nil,
                        headers: ["x-api-key": ApiKeys.catApiKey],
                        query: nil,
                        decoder: nil)
    }
    
    func searchImages(searchText: String, page: Int, limit: Int) -> AnyPublisher<[CatImage], NetworkError> {
        apiService.call(method: .get,
                        apiUrl: .parent("/images/search"),
                        type: [CatImage].self,
                        body: nil,
                        headers: ["x-api-key": ApiKeys.catApiKey],
                        query: ["q": searchText,
                                "page": page,
                                "limit": limit],
                        decoder: nil)
    }
}

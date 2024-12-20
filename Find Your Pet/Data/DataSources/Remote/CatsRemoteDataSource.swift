//
//  CatsRemoteDataSource.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Foundation
import Combine

// MARK: - CatsRemoteDataSource Protocol

protocol CatsRemoteDataSource {
    func getCatImages(limit: Int, breedID: String?, page: Int?, order: String?) -> AnyPublisher<[PetImageModel], NetworkError>
    func getImageByID(imageID: String) -> AnyPublisher<PetImageModel, NetworkError>
}

// MARK: - Implementation

class CatsRemoteDataSourceImpl: CatsRemoteDataSource {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getCatImages(limit: Int = 10, breedID: String? = nil, page: Int? = nil, order: String? = "RAND") -> AnyPublisher<[PetImageModel], NetworkError> {
        var query: [String: Any] = ["limit": limit, "order": order ?? "RAND"]
        
        if let breedID = breedID {
            query["breed_ids"] = breedID
        }
        if let page = page {
            query["page"] = page
        }
        
        return apiService.call(
            method: .get,
            environment: .catAPI,
            path: "/images/search",
            type: [PetImageModel].self,
            body: nil,
            query: query,
            decoder: nil
        )
    }
    
    func getImageByID(imageID: String) -> AnyPublisher<PetImageModel, NetworkError> {
        return apiService.call(
            method: .get,
            environment: .catAPI,
            path: "/images/\(imageID)",
            type: PetImageModel.self,
            body: nil,
            query: nil,
            decoder: nil
        )
    }
}

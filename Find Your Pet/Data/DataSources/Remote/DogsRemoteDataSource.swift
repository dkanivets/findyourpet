//
//  DogsRemoteDataSource.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import Foundation
import Combine

// MARK: - DogsRemoteDataSource Protocol

protocol DogsRemoteDataSource {
    func getDogImages(limit: Int, breedID: String?, page: Int?, order: String?) -> AnyPublisher<[PetImageModel], NetworkError>
    func getImageByID(imageID: String) -> AnyPublisher<PetImageModel, NetworkError>
}

// MARK: - Implementation

class DogsRemoteDataSourceImpl: DogsRemoteDataSource {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    // Fetch multiple dog images with optional filters
    func getDogImages(limit: Int = 10, breedID: String? = nil, page: Int? = nil, order: String? = "RAND") -> AnyPublisher<[PetImageModel], NetworkError> {
        var query: [String: Any] = ["limit": limit, "order": order ?? "RAND"]
        
        if let breedID = breedID {
            query["breed_ids"] = breedID
        }
        if let page = page {
            query["page"] = page
        }
        
        return apiService.call(
            method: .get,
            environment: .dogAPI, // Use Dog API base URL
            path: "/images/search",
            type: [PetImageModel].self,
            body: nil,
            query: query,
            decoder: nil
        )
    }
    
    // Fetch a single image by its ID
    func getImageByID(imageID: String) -> AnyPublisher<PetImageModel, NetworkError> {
        return apiService.call(
            method: .get,
            environment: .dogAPI, // Use Dog API base URL
            path: "/images/\(imageID)",
            type: PetImageModel.self,
            body: nil,
            query: nil,
            decoder: nil
        )
    }
}

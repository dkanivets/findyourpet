//
//  CatRepositoryImp.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Foundation

class RemoteCatRepository: CatRepository {
    private let baseURL = "https://api.thecatapi.com/v1"
    private let apiKey = "YOUR_API_KEY" // Replace with your API key
    
    func fetchCatImages(completion: @escaping (Result<[CatImage], NetworkError>) -> Void) {
        let endpoint = "\(baseURL)/images/search?limit=10"
        let headers = ["x-api-key": apiKey]
        
//        ApiService.shared.request(endpoint: endpoint, headers: headers, completion: completion)
    }
}

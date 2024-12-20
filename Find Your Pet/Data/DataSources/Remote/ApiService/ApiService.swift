//
//  ApiService.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Foundation
import Combine

// MARK: - Enums for API Configuration

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ApiEnvironment {
    case catAPI
    case dogAPI
    
    var baseURL: String {
        switch self {
        case .catAPI:
            return "https://api.thecatapi.com/v1"
        case .dogAPI:
            return "https://api.thedogapi.com/v1"
        }
    }
}

// MARK: - NetworkError

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case unknown(Error)
}

// MARK: - ApiService Protocol

protocol ApiService {
    func call<ModelType: Decodable>(
        method: HttpMethod,
        environment: ApiEnvironment,
        path: String,
        type: ModelType.Type,
        body: (() -> Data)?,
        query: [String: Any]?,
        decoder: (() -> JSONDecoder)?
    ) -> AnyPublisher<ModelType, NetworkError>
}

// MARK: - Implementation: ApiServiceImp

class ApiServiceImp: ApiService {
    private let apiKey: String = "live_cEiogH9AihuuTABVmSI8LQuTfgwAEQKLMwEnrw1bZOKXaBYmsZc6sDMLdsvpWpDO"
    
    func call<ModelType: Decodable>(
        method: HttpMethod,
        environment: ApiEnvironment,
        path: String,
        type: ModelType.Type,
        body: (() -> Data)? = nil,
        query: [String: Any]? = nil,
        decoder: (() -> JSONDecoder)? = nil
    ) -> AnyPublisher<ModelType, NetworkError> {
        let baseURL = environment.baseURL
        guard var urlComponents = URLComponents(string: baseURL + path) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        var queryWithApiKey = query ?? [:]
        queryWithApiKey["api_key"] = apiKey
        urlComponents.queryItems = queryWithApiKey.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        guard let finalURL = urlComponents.url else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        if let body = body {
            request.httpBody = body()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.requestFailed
                }
                return data
            }
            .decode(type: ModelType.self, decoder: decoder?() ?? JSONDecoder())
            .mapError { error in
                if error is DecodingError {
                    return .decodingFailed
                } else if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return .unknown(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

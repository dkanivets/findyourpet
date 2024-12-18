//
//  ApiService.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 18.12.2024.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case unknown(Error)
}

enum URLPath {
    case parent(String)
    
    func url(withQuery query: [String: Any]? = nil) -> URL? {
        let baseURL = "https://api.thecatapi.com/v1"
        var components = URLComponents(string: baseURL + parentPath)
        if let query = query {
            components?.queryItems = query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        return components?.url
    }
    
    private var parentPath: String {
        switch self {
        case .parent(let path):
            return path
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct ApiKeys {
    static let catApiKey = ""
}

class ApiService {
    func call<T: Decodable>(
        method: HTTPMethod,
        apiUrl: URLPath,
        type: T.Type,
        body: [String: Any]? = nil,
        headers: [String: String]? = nil,
        query: [String: Any]? = nil,
        decoder: JSONDecoder? = nil
    ) -> AnyPublisher<T, NetworkError> {
        guard let url = apiUrl.url(withQuery: query) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach { key, value in request.setValue(value, forHTTPHeaderField: key) }
        
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.requestFailed
                }
                return data
            }
            .decode(type: T.self, decoder: decoder ?? JSONDecoder())
            .mapError { error in
                error is DecodingError ? .decodingFailed : .unknown(error)
            }
            .eraseToAnyPublisher()
    }
}

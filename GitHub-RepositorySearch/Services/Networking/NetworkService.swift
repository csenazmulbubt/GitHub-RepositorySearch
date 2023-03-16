//
//  NetworkService.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 16/03/2023.
//

import Foundation
import Combine

//MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(type: T.Type, url: URL) -> AnyPublisher<T, NetworkRequestError>
}

// MARK: - NetworkService

struct NetworkService: NetworkServiceProtocol {
    
    func fetchData<T>(type: T.Type, url: URL) -> AnyPublisher<T, NetworkRequestError> where T : Decodable {
        
        let urlRequest = URLRequest(url: url)
        
        guard NetworkManager.isNetworkAvailable else {
            return Fail(error: NetworkRequestError.noIntenet)
                .eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in NetworkRequestError.invalidRequest }
            .flatMap { data, response -> AnyPublisher<T, NetworkRequestError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: NetworkRequestError.invalidResponse)
                        .eraseToAnyPublisher()
                }
                
                guard 200..<300 ~= response.statusCode else {
                    return Fail(error: NetworkServiceError.getNetworError(statusCode: response.statusCode))
                        .eraseToAnyPublisher()
                }
                
                return Just(data)
                    .decode(type: T.self, decoder: decoder)
                    .mapError {_ in NetworkRequestError.jsonDecodingError}
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

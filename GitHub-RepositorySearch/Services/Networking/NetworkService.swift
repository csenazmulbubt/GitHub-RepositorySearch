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
    func fetchData<T: Decodable>(type: T.Type, urlRequest: URLRequest) -> AnyPublisher<T, NetworkRequestError>
}

// MARK: - NetworkService

struct NetworkService: NetworkServiceProtocol {
    
    /**
     Default implementation of the NetworkService fetchData(_:) method.
     Performs an APIRequest and tries to decode the response as a Decodable Response.
     - Parameter request: GenericsType and Url
     - Returns: A Publisher transmitting a Decodable Response defined by the HTTP URl Resoponse.
     */
    
    func fetchData<T>(type: T.Type, urlRequest: URLRequest) -> AnyPublisher<T, NetworkRequestError> where T : Decodable {
        
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

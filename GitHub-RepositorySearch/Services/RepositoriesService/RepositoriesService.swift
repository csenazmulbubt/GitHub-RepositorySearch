//
//  RepositoresService.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 16/03/2023.
//

import Foundation
import Combine

//MARK: - RepositoriesServiceProtocol
///// A protocol defining the requirements to a service allowing to perform repositories search at GitHub

protocol RepositoriesServiceProtocol {
    var networkService: NetworkServiceProtocol { get }
    
    /// Method to perform repositories search by a string query and a number of page in the SearchRepositoriesResponse list
    func searchRepositories(query: String, page: Int) -> AnyPublisher<SearchRepositoriesResponse, NetworkRequestError>
}

//MARK: - RepositoriesService

// Default implementation of the RepositoriesService protocol

struct RepositoriesService:  RepositoriesServiceProtocol {
    
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
     /*Searches for repositories by a string query and a page number via the NetworkService.
     - Parameter query: A String to search the repoositories by.
     - Parameter page: A page to return among all the results for the given query.
     - Returns: A Publisher transmitting the search results.
     */
    func searchRepositories(query: String, page: Int) -> AnyPublisher<SearchRepositoriesResponse, NetworkRequestError> {
        
        let endpoint = EndPoint.searchRepositories(query: query, pageNo: page, httpMethod: .get)
       
        let key = "\(query)-\(page)"
        
        if !NetworkManager.isNetworkAvailable {
            if let cachedResult = ApiCache.shared.getResponseData(key: key) as? SearchRepositoriesResponse {
                return Just(cachedResult)
                    .setFailureType(to: NetworkRequestError.self)
                    .eraseToAnyPublisher()
            }
            else{
                return Fail(error: NetworkRequestError.noIntenet)
                    .eraseToAnyPublisher()
            }
        }
        return networkService
            .fetchData(type: SearchRepositoriesResponse.self, urlRequest: endpoint.urlRequest).handleEvents(receiveOutput: {  response in
                ApiCache.shared.setResponseData(response as AnyObject, key: key)
            })
            .eraseToAnyPublisher()
    }
}

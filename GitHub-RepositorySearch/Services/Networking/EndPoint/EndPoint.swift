//
//  EndPoint.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 16/03/2023.
//

import Foundation

//MARK: - Endpoint
/// Github Repositories Search Request EndPoint URL Design

struct EndPoint {
    var path: String
    var queryItems: [URLQueryItem] = []
    var httpMethod: HTTPMethod = .get
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/search" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 20
        urlRequest.httpMethod = httpMethod.rawValue
        return urlRequest
    }
    
    static func searchRepositories(query: String, pageNo: Int, httpMethod: HTTPMethod = .get) -> Self {
       
        // Searching Paramenter
        let items: [URLQueryItem] = [.init(name: "q", value: "\(query)"),.init(name: "page", value: "\(pageNo)")]
        
        return EndPoint(path: "/repositories", queryItems: items, httpMethod: httpMethod)
    }
}

//
//  EndPoint.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 16/03/2023.
//

import Foundation


struct EndPoint {
    var path: String
    var queryItems: [URLQueryItem] = []
    
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
    
    static func searchRepositories(query: String, pageNo: Int) -> Self {
       
        // Searching Paramenter
        let items: [URLQueryItem] = [.init(name: "q", value: "\(query)"),.init(name: "page", value: "\(pageNo)")]
        
        return EndPoint(path: "/repositories", queryItems: items)
    }
}

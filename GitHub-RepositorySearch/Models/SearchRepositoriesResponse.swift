//
//  SearchRepositoriesResponse.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 15/03/2023.
//

import Foundation

//MARK : - SearchRepositoriesResponse
///https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#get-a-repository

public struct SearchRepositoriesResponse : Codable {
   
    public let items : [SearchRepositoriesItem]?
    public var totalCount : Int?

    enum CodingKeys: String, CodingKey {
        case items
        case totalCount = "total_count"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([SearchRepositoriesItem].self, forKey: .items)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
    }
}

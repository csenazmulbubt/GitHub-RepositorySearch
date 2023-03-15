//
//  SearchRepositoriesItem.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 15/03/2023.
//


import Foundation

public struct SearchRepositoriesItem : Codable {
    public let createdAt : String?
    public let fullName : String?
    public let id : Int?
    public let language : String?
    public let name : String?
    public let owner : SearchRepositoriesOwner?
    public let stargazersCount : Int?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case fullName = "full_name"
        case id
        case language
        case name
        case owner
        case stargazersCount = "stargazers_count"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        owner = try values.decodeIfPresent(SearchRepositoriesOwner.self, forKey: .owner)
        stargazersCount = try values.decodeIfPresent(Int.self, forKey: .stargazersCount)
    }
}

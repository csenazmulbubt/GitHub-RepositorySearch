//
//  SearchRepositoriesOwner.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 15/03/2023.
//

import Foundation

//MARK: - SearchRepositoriesOwner
/// A lot of atrriubte but at this moment don't need All
/// https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#get-a-repository

public struct SearchRepositoriesOwner : Codable {
    public let avatarUrl : String?
    public let id : Int?
    public let login : String?

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case id
        case login
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        login = try values.decodeIfPresent(String.self, forKey: .login)
    }
}

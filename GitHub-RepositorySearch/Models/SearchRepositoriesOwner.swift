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
    public let id : Int
    public let login : String
    public let avatarUrl : String?
}

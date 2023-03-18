//
//  SearchRepositoriesItem.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 15/03/2023.
//


import Foundation

//MARK: - SearchRepositoriesItem
/// A lot of atrriubte but at this moment don't need All
/// https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#get-a-repository

public struct SearchRepositoriesItem : Codable,Identifiable {
    public var id, stargazersCount: Int
    public let name, fullName, language, createdAt: String?
    public let owner: SearchRepositoriesOwner
    public let htmlUrl: URL
    
}

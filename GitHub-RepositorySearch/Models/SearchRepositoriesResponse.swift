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
    let totalCount: Int
    let incompleteResults: Bool
    let items: [SearchRepositoriesItem]
}

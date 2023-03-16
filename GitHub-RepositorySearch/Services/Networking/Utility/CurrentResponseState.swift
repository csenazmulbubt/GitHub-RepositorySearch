//
//  CurrentResponseState.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 16/03/2023.
//

import Foundation

//Current Response State Enum When Fetching Data

enum ResponseState {
    case display(items: SearchRepositoriesResponse, _ hasNexPage: Bool)
    case empty(message: String)
    case loading
    case error(message: String)
}


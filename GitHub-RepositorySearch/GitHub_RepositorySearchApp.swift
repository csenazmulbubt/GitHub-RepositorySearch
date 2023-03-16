//
//  GitHub_RepositorySearchApp.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 15/03/2023.
//

import SwiftUI

@main
struct GitHub_RepositorySearchApp: App {
    let viewModel = RepositoriesSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            RepositoriesSearchView(viewModel: viewModel)
        }
    }
}

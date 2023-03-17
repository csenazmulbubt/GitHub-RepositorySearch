//
//  RepositoriesSearchView.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 16/03/2023.
//

import SwiftUI
import Combine

//MARK: - RepositoriesSearchView

struct RepositoriesSearchView: View {
    @ObservedObject var viewModel: RepositoriesSearchViewModel
    
    var body: some View {
        NavigationView {
            RepositoriesContentView(viewModel: viewModel)
                .navigationTitle(String.repositories)
        }.searchable(text: $viewModel.searchText, prompt: String.search)
    }
}

//MARK: - RepositoriesContentView
private struct RepositoriesContentView: View {
    @ObservedObject var viewModel: RepositoriesSearchViewModel

    var body: some View {
        switch viewModel.state {
        case let .display(items, hasNextPage):
            MessageView(message: "", color: .gray)
        case let .empty(message):
            MessageView(message: message, color: .gray)
        case let .error(message):
            MessageView(message: message, color: .red)
        case .loading:
            LoadingView()
        }
    }
}

// A private String extension just to keep "raw" strings out of the code
private extension String {
    static let repositories = "Repositories"
    static let search = "Search repository"
    static let loadingNext = "Loading..."
}

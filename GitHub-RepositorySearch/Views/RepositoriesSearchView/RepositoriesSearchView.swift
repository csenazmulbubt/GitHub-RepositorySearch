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
                .navigationViewStyle(StackNavigationViewStyle())
        }.searchable(text: $viewModel.searchText, prompt: String.search)
            .onChange(of: viewModel.searchText) { _ in
                //When User Cancel searchbar forcely state change
                if viewModel.searchText.isEmpty {
                    viewModel.resetStateForcely()
                }
            }
    }
}

//MARK: - RepositoriesContentView
private struct RepositoriesContentView: View {
    @ObservedObject var viewModel: RepositoriesSearchViewModel
    
    var body: some View {
        switch viewModel.state {
        case let .display(items, hasNextPage):
            RepositoriesListView(repoSearchViewModel: viewModel, repoListItems: items, hasNextPage: hasNextPage)
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
}

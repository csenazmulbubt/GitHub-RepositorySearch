//
//  RepositoriesSearchViewModel.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 16/03/2023.
//

import Foundation
import Combine

class RepositoriesSearchViewModel: ObservableObject {
    private static let firstPage = 1
    
    @Published var searchText = ""
    @Published var page = RepositoriesSearchViewModel.firstPage
    @Published var state: ResponseState = .empty(message: .searchRepositories)
    
    private var repositoriesService: RepositoriesServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repositoriesService: RepositoriesServiceProtocol = RepositoriesService()) {
        self.repositoriesService = repositoriesService
        _ = NetworkMonitor.shared
        setupBinding()
    }
    
    private func setupBinding() -> Void {
       
    }
}


// A private String extension just to keep "raw" strings out of the code
private extension String {
    static let searchRepositories = "Search Repositories"
    static let noRepositories = "No Repositories Found"
}

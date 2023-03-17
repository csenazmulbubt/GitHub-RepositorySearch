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
        // Fired when user is typing a query in the SearchBar
        let newSearch = $searchText
            .dropFirst(1)
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .handleEvents(receiveOutput: { [unowned self] _ in
                // When we get a new search query, reset the pagination counter
                self.page = Self.firstPage
            })
            .map { (searchText: $0, page: Self.firstPage) }

        // Fired when user has scrolled all the way down to the end of currently displayed list
       let nextPage = $page
            .dropFirst(1)
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .map { [unowned self] in (searchText: self.searchText, page: $0) }

        // In both cases, search for repositories via the searchService by query and page
        Publishers.Merge(newSearch, nextPage)
            .removeDuplicates(by: { $0.searchText == $1.searchText && $0.page == $1.page })
            .flatMapLatest { [unowned self] searchText, page -> AnyPublisher<ResponseState, Never> in
                if page == Self.firstPage {
                    state = .loading
                }
               return self.fetchData(query: searchText, page: page)
            }
            .sink(receiveValue: { [weak self] state in
                guard let self = self else { return  }
                self.state = state
            })
            .store(in: &cancellables)
    }
    
    private func fetchData(query: String, page: Int) -> AnyPublisher<ResponseState, Never> {
        
        guard !query.isEmpty else {
            return Just(.empty(message: .searchRepositories)).eraseToAnyPublisher()
        }
        
        return repositoriesService.searchRepositories(query: query, page: page)
            .map { [weak self] response -> ResponseState in
                guard let self = self else {
                    return .empty(message: .searchRepositories)
                }
                let newItems = response.items
                print("NewItems Count",response.totalCount,newItems)
                return .display(items: newItems ?? [], false)
            }
            .catch { Just(.error(message: $0.localizedDescription)).eraseToAnyPublisher() }
            .eraseToAnyPublisher()
    }
    
}


// A private String extension just to keep "raw" strings out of the code
private extension String {
    static let searchRepositories = "Search Repositories"
    static let noRepositories = "No Repositories Found"
}

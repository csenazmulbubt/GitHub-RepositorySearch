//
//  RepositoriesListView.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 17/03/2023.
//

import SwiftUI
import UIKit.UIImage

//MARK: - RepositoriesListView

struct RepositoriesListView: View {
   
    @ObservedObject var repoSearchViewModel: RepositoriesSearchViewModel
    let repoListItems: [RepositoriesListViewModel]
    let hasNextPage: Bool
    
    var body: some View {
        List {
            ForEach(repoListItems) { item in
                NavigationLink(destination: DetailView(repoListViewModel: item)) {
                    RepositoriesListContentView(repoListViewModel: item)
                }
            }
            if hasNextPage {
                PageLoadingRow(viewModel: repoSearchViewModel)
            }
        }
    }
}

//MARK: - RepositoriesListContentView

private struct RepositoriesListContentView: View {
   
    @ObservedObject private var repoListViewModel: RepositoriesListViewModel
    private let screenWidth = UIScreen.main.bounds.width
    
    public init(repoListViewModel: RepositoriesListViewModel) {
        self.repoListViewModel = repoListViewModel
    }
    
    var body: some View {
        HStack {
            Image(uiImage: repoListViewModel.avatar)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: screenWidth * 0.2,
                       height: screenWidth * 0.2,
                       alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 1))
            VStack(alignment: .leading) {
                Spacer(minLength: 8)
                Text(repoListViewModel.fullName).bold()
                Spacer(minLength: 4)
                Text("Language:  \(repoListViewModel.language)")
                HStack {
                    Text("Star: ")
                    Text(repoListViewModel.star).foregroundColor(.blue)
                }
                Spacer(minLength: 8)
            }
            Spacer()
        }
    }
}

//MARK: - PageLoadingRow

private struct PageLoadingRow: View {
    @ObservedObject var viewModel: RepositoriesSearchViewModel
    
    var body: some View {
        HStack{
            Spacer()
            ProgressView()
                .scaleEffect(1.0, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                .onAppear {
                    // When scrolled all the way down - request the next page fetch
                    viewModel.page += 1
                }
            Spacer()
        }
    }
}


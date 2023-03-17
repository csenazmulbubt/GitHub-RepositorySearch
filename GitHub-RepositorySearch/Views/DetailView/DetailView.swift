//
//  DetailView.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 18/03/2023.
//

import Foundation
import SwiftUI
import Combine

struct DetailView: View {
    @ObservedObject var repoListViewModel: RepositoriesListViewModel
    
    var body: some View {
        VStack {
            ScrollContent(repoListViewModel: repoListViewModel)
        }
        .navigationBarTitle(repoListViewModel.ownerName)
    }
}

struct ImageView: View {
    let avatarImage: UIImage
    private let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        HStack {
            Image(uiImage: avatarImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: screenWidth * 0.5,
                       height: screenWidth * 0.5,
                       alignment: .center)
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.blue, lineWidth: 1))
        }
    }
}

struct ScrollContent: View {
    let repoListViewModel: RepositoriesListViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            VStack(spacing: 10) {
                ImageView(avatarImage: repoListViewModel.avatar)
                VStack (alignment: .leading, spacing: 20){
                    TextView(label: "Repo Name: ", text: repoListViewModel.repoName)
                    TextView(label: "Craeted At : ", text: repoListViewModel.creationTime)
                    TextView(label: "Star Count: ", text: repoListViewModel.star)
                    TextView(label: "Language: ", text: repoListViewModel.language)
                }
                .padding(.top, 20)
                Spacer()
            }
        }
    }
}

struct TextView: View {
    let label: String
    let text: String
    
    var body: some View {
        HStack {
            Text(label).bold()
            Text(text).italic()
        }
    }
}

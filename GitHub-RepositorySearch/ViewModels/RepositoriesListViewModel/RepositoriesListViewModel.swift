//
//  RepositoriesListViewModel.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 17/03/2023.
//

import Foundation
import UIKit.UIImage
import Combine

//MARK: - RepositoriesListViewModel

class RepositoriesListViewModel: Identifiable, ObservableObject {
    
    @Published public var avatar = UIImage()
    
    private let repoItem: SearchRepositoriesItem
    private var cancellable: AnyCancellable?
    
    public init(repoItem: SearchRepositoriesItem) {
        self.repoItem = repoItem
        loadAvatarImage()
    }
    
    public var ownerName: String {
        repoItem.owner.login
    }
    
    public var htmlUrl: URL {
        repoItem.htmlUrl
    }
    public var creationTime: String {
        guard let strDate = repoItem.createdAt,
              let date = RepositoriesListViewModel.dateFormatterServer
                .date(from: strDate) else {fatalError("invalid date")}
        return RepositoriesListViewModel.dateFormatterLocal.string(from: date)
    }
    
    public var repoName: String {
        repoItem.name ?? "NA"
    }
    
    public var fullName: String {
        repoItem.fullName ?? "NA"
    }
    
    public var star: String {
        "\(repoItem.stargazersCount)"
    }
    
    public var language: String {
        repoItem.language ?? "NA"
    }
    
    private func loadAvatarImage(){
        guard let strUrl = repoItem.owner.avatarUrl,
              let url = URL(string: strUrl) else { return }
        cancellable = ImageLoader.shared.loadImage(from: url)
            .sink(receiveValue: { [weak self](image) in
                if let image = image {
                    self?.avatar = image.resizeImage(img: image)
                }
            })
    }
}

extension RepositoriesListViewModel {
    private static let dateFormatterServer: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    
    private static let dateFormatterLocal: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy hh:mm a"
        formatter.timeZone =  TimeZone.current
        return formatter
    }()
}

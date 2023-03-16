//
//  NetworkManager.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 16/03/2023.
//

import Foundation

struct NetworkManager {
    static var isNetworkAvailable: Bool {
        NetworkMonitor.shared.isConnected
    }
}

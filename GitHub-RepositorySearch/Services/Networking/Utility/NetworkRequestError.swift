//
//  NetworkError.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 16/03/2023.
//

import Foundation

//MARK: - NetworkRequestError

enum NetworkRequestError: LocalizedError, Equatable {
    case errorMessage(_ message: String)
    case decodingError( _ description: String)
    case urlSessionFailed(_ error: URLError)
    case unknownError
}

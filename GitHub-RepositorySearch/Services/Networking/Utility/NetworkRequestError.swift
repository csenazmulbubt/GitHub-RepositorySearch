//
//  NetworkError.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 16/03/2023.
//

import Foundation

//MARK: - NetworkRequestError

enum NetworkRequestError: LocalizedError, Equatable {
    case noIntenet
    case invalidRequest
    case invalidResponse
    case dataLoadingError(_ statusCode: Int, _ data: Data)
    case jsonDecodingError
    case errorMesage(_ message: String)
    
    var errorDescription: String?{
        switch self {
        case .noIntenet: return "No Internet conection"
        case .invalidRequest: return "Invalid request"
        case .invalidResponse: return "Invalid reponse"
        case .dataLoadingError(let code, _): return "Error Code = \(code)"
        case .jsonDecodingError: return "JSON decoding failed."
        case .errorMesage (let message):
            return message
        }
    }
}


struct NetworkServiceError {
    
    static func getNetworError(statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 304:
            return NetworkRequestError.errorMesage("Not Modified")
        case 403:
            return NetworkRequestError.errorMesage("API rate limit exceeded")
        case 422:
            return NetworkRequestError.errorMesage("Validation failed, or the endpoint has been spammed")
        case 503:
            return NetworkRequestError.errorMesage("Service unavailable")
        default:
            return NetworkRequestError.errorMesage("Something went wrong!")
        }
    }
}

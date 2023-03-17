//
//  Publisher + Extension.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 17/03/2023.
//

import Foundation
import Combine

extension Publisher {
    func flatMapLatest<P: Publisher>(_ transform: @escaping (Output) -> P) -> Publishers.SwitchToLatest<P, Publishers.Map<Self, P>> {
        map(transform).switchToLatest()
    }
}


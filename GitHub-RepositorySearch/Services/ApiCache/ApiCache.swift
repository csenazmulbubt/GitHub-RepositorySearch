//
//  CacheManager.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 18/03/2023.
//

import Foundation

// Caching class
class ApiCache {
    static let shared = ApiCache()
    
    private var cache = NSCache<NSString, AnyObject>()
    
    private init() {}
    
    func setResponseData(_ object: AnyObject, key: String) {
        cache.setObject(object , forKey: key as NSString)
    }
    
    func getResponseData(key: String) -> AnyObject? {
        if let cachedData = cache.object(forKey: key as NSString) {
            return cachedData
        }
        return nil
    }
}

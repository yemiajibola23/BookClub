//
//  LibraryAPIClient.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/28/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

// Responsible for handling Library API

import Foundation

enum ResourceType: String {
    case Items = "items"
    case Collections = "collections"
}

struct LibraryAPIClient {
    private static let baseURLString = "http://api.dp.la/v2/"
    private static let APIKey = "3c49a8cebbfd0334a9d3bc88c48756a0"
    
    private static func librarySearchURL(resourceType: ResourceType, query: String) -> URL {
        var components = URLComponents(string: baseURLString + resourceType.rawValue)!
        var queryItems = [URLQueryItem]()
        
        let params = [
            "q": query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            "api_key": APIKey
        ]
        
        for (key, value) in params {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        components.queryItems = queryItems
        
        return components.url!
    }
    
    static func searchCollectionURL(query: String) -> URL {
        return librarySearchURL(resourceType: .Collections, query: query)
    }
    
    static func searchItemURL(query: String) -> URL {
        return librarySearchURL(resourceType: .Items, query: query)
    }
}




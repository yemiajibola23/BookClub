//
//  BookStore.swift
//  BookClub
//
//  Created by Yemi Ajibola on 11/1/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

// Responsible for handling web service calls

import Foundation

//protocol BookClubURLSession {
////    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
//    func dataTask(with request: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
//}

class BookStore {
    lazy var session: URLSession = {
        let config  = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchBooksForItemQuery(query: String) {
        let url = LibraryAPIClient.searchItemURL(query: query)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {  (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                    print(jsonString)
                }
            } else if let requestError = error {
                print("Error fetcing recent photos: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
        }
        
        task.resume()
    }
}


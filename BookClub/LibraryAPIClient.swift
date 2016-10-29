//
//  LibraryAPIClient.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/28/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import Foundation

protocol BookClubURLSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}


struct LibraryAPIClient {
    lazy var session: BookClubURLSession = URLSession.shared
    private static let baseURLString = "http://api.dp.la/v2/"
    let apiKey = "3c49a8cebbfd0334a9d3bc88c48756a0"
}


extension URLSession: BookClubURLSession { }

//
//  BookStoreTests.swift
//  BookClub
//
//  Created by Yemi Ajibola on 11/1/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import XCTest
@testable import BookClub

class BookStoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLibraryAPICallReceivesResponse() {
        let sut = BookStore()
        let mockURLSession = MockURLSession()
        sut.session = mockURLSession
        
    }
    
}
extension BookStoreTests {
    class MockURLSession: BookClubURLSession {
        typealias Handler = (Data?, URLResponse?, Error?) -> Void
        
        var completionHandler: Handler?
        var url: URL?
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            self.completionHandler = completionHandler
            return URLSession.shared.dataTask(with: url)
        }
    }
}

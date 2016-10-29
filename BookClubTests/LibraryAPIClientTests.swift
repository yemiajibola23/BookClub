//
//  LibraryAPIClientTests.swift
//  BookClub
//
//  Created by Yemi Ajibola on 10/28/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import XCTest
@testable import BookClub

class LibraryAPIClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLibraryAPIClientGivesBackResponse() {
        var sut = LibraryAPIClient()
        let mockURLSession = MockURLSession()
        
        sut.session = mockURLSession
    }
    
}

extension LibraryAPIClientTests {
    class MockURLSession: BookClubURLSession {
        typealias Handler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: Handler?
        var url: URL?
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
            self.url = url
            self.completionHandler = completionHandler
            
            return URLSession.shared.dataTask(with: url)
        }
    }
}

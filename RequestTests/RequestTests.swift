//
//  RequestTests.swift
//  RequestTests
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import XCTest
import Request

struct User : Convertible {
    var id: Int?
    var name: String
}

class RequestTests: XCTestCase {
    
    func testRequestBuilder() {
        let startExpectation = self.expectationWithDescription("Start")
        let successExpectation = self.expectationWithDescription("Success")
        let responseExpecation = self.expectationWithDescription("Response")
        let completionExpectation = self.expectationWithDescription("Completion")
        POST<User>("http://jsonplaceholder.typicode.com/")
        .headers(["Content-Type":"application/json"])
        .path("/users")
        .body(User(id: nil, name: "Brad Hilton"))
        .start { (request) -> Void in
            startExpectation.fulfill()
        }.success { (response, request) -> Void in
            XCTAssert(response.body.id != nil)
            XCTAssert(response.body.name == "Brad Hilton")
            successExpectation.fulfill()
        }.failure { (error, request) -> Void in
            XCTFail("Error: \(error)")
        }.response(201) { (response, request) -> Void in
            responseExpecation.fulfill()
        }.completion { (response, errors, request) -> Void in
            completionExpectation.fulfill()
        }.begin()
        waitForExpectationsWithTimeout(100, handler: nil)
    }
    
}

//
//  Response.swift
//  Request
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation
import Convertible

public struct Response<Body : DataInitializable> {
    
    public let body: Body
    public let response: NSHTTPURLResponse
    internal let options: [ConvertibleOption]
    
    public var statusCode: Int {
        return response.statusCode
    }
    
    public var headers: [String : String] {
        return response.allHeaderFields as? [String : String] ?? [:]
    }
    
    internal init(body: Body, response: NSHTTPURLResponse, options: [ConvertibleOption]) {
        self.body = body
        self.response = response
        self.options = options
    }
    
    internal init(data: NSData, response: NSHTTPURLResponse, options: [ConvertibleOption]) throws {
        try self.init(body: Body.initializeWithData(data, options: options), response: response,  options: options)
    }
    
}
//
//  Request.swift
//  Request
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation
import Convertible

extension Request {
    
    public struct Builder : _RequestBuilder {
        
        public typealias ResponseType = NSData
        
        private let request: Request
        
        public init(_ request: Request) {
            self.request = request
        }
        
        public func create() -> Request {
            return request
        }
        
        public func method(method: Method) -> Builder {
            return modify { (inout request: Request) in request.method = method }
        }
        
    }
    
}

public struct GET<T : DataInitializable> : _RequestBuilder {
    
    public typealias ResponseType = T
    
    private let request: Request
    
    public init(_ request: Request) {
        var copy = request
        copy.method = .GET
        self.request = copy
    }
    
    public func create() -> Request {
        return request
    }
    
}

public struct POST<T : DataInitializable> : _RequestBuilder {
    
    public typealias ResponseType = T
    
    private let request: Request
    
    public init(_ request: Request) {
        var copy = request
        copy.method = .POST
        self.request = copy
    }
    
    public func create() -> Request {
        return request
    }
    
}

public struct PUT<T : DataInitializable> : _RequestBuilder {
    
    public typealias ResponseType = T
    
    private let request: Request
    
    public init(_ request: Request) {
        var copy = request
        copy.method = .PUT
        self.request = copy
    }
    
    public func create() -> Request {
        return request
    }
    
}

public struct DELETE<T : DataInitializable> : _RequestBuilder {
    
    public typealias ResponseType = T
    
    private let request: Request
    
    public init(_ request: Request) {
        var copy = request
        copy.method = .DELETE
        self.request = copy
    }
    
    public func create() -> Request {
        return request
    }
    
}

public struct PATCH<T : DataInitializable> : _RequestBuilder {
    
    public typealias ResponseType = T
    
    private let request: Request
    
    public init(_ request: Request) {
        var copy = request
        copy.method = .PATCH
        self.request = copy
    }
    
    public func create() -> Request {
        return request
    }
    
}




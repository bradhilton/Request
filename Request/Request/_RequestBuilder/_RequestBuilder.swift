//
//  RequestBuilder.swift
//  Request
//
//  Created by Bradley Hilton on 2/6/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

public protocol _RequestBuilder {
    associatedtype ResponseType : DataInitializable
    func create() -> Request
    init(_ request: Request)
}

extension _RequestBuilder {
    
    public init() {
        self.init(Request())
    }
    
    public init(_ url: Url) {
        self.init(Request(url))
    }
    
    public init(_ string: String) {
        self.init(Request(string))
    }
    
    public init<T : DataInitializable, U : _RequestBuilder where U.ResponseType == T>(_ builder: U) {
        self.init(builder.create())
    }
    
    public func modify(handler: (inout Request) -> ()) -> Self {
        var request = self.create()
        handler(&request)
        return Self(request)
    }
    
    public func url(url: Url) -> Self {
        return modify { (inout request: Request) in request.url = url }
    }
    
    public func mainDocumentUrl(url: Url?) -> Self {
        return modify { (inout request: Request) in request.mainDocumentURL = url }
    }
    
    public func headers(headers: [String : String]?) -> Self {
        return modify { (inout request: Request) in request.headers = headers ?? [:] }
    }
    
    public func appendHeaders(headers: [String : String?]) -> Self {
        return modify { (inout request: Request) in
            for (field, value) in headers {
                request.headers[field] = value
            }
        }
    }
    
    public func body(body: DataSerializable?) -> Self {
        return modify { (inout request: Request) in request.body = body }
    }
    
    public func configuration(configuration: Configuration) -> Self {
        return modify { (inout request: Request) in request.configuration = configuration }
    }
    
    public func queue(queue: NSOperationQueue) -> Self {
        return modify { (inout request: Request) in request.callbacks.queue = queue }
    }
    
    public func options(options: [ConvertibleOption]) -> Self {
        return modify { (inout request: Request) in request.options = options }
    }
    
    public func logging(logging: Bool) -> Self {
        return modify { (inout request: Request) in request.logging = logging }
    }
    
    public func begin() -> NSURLSessionTask {
        return create().begin()
    }
    
}
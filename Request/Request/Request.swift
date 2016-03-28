//
//  Request.swift
//  Request
//
//  Created by Bradley Hilton on 2/5/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

public struct Request {
    
    public var url: Url = Url()
    public var mainDocumentURL: Url?
    public var method: Method = .GET
    public var headers: [String : String] = [:]
    public var body: DataSerializable?
    public var configuration: Configuration = Configuration()
    public var callbacks = Callbacks()
    public var options = [ConvertibleOption]()
    public var logging = false
    
    public init(_ url: Url) {
        self.url = url
    }
    
    public init(_ string: String) {
        self.url = Url(string)
    }
    
    public init() {
        self.url = Url()
    }
    
    public func build() -> Builder {
        return Builder(self)
    }
    
    public func begin() -> NSURLSessionTask {
        return TaskDelegate(request: self).task()
    }
    
}
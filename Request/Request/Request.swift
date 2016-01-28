//
//  Request.swift
//  Request
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation
import Convertible

public class Request {
    
    internal var data = Request.Data()
    
    public init(_ absoluteString: String) {
        self.absoluteString(absoluteString)
    }
    
    public init(_ request: Request) {
        self.data = request.data
    }
    
    public func request(request: NSURLRequest) -> Self {
        guard let request = request.mutableCopy() as? NSMutableURLRequest else { return self }
        data.request = request
        return self
    }
    
    public func body(body: DataSerializable?) -> Self {
        data.body = body
        return self
    }
    
    public func configuration(configuration: NSURLSessionConfiguration) -> Self {
        guard let configuration = configuration.copy() as? NSURLSessionConfiguration else { return self }
        data.configuration = configuration
        return self
    }
    
    public func queue(queue: NSOperationQueue?) -> Self {
        data.queue = queue
        return self
    }
    
    public func options(options: [ConvertibleOption]) -> Self {
        data.options = options
        return self
    }
    
    public func logging(logging: Bool) -> Self {
        data.logging = logging
        return self
    }
    
    public func begin() -> NSURLSessionTask {
        return TaskDelegate(data: data.copy).task()
    }
    
    public func successCodes(successCodes: ResponseCodes...) -> Self {
        return self.successCodes(successCodes)
    }
    
    internal func successCodes(successCodes: [ResponseCodes]) -> Self {
        data.handlers.successCodes = reduceResponseCodes(successCodes)
        return self
    }
    
    public func success<T : DataInitializable>(successCodes: ResponseCodes..., handler: ((response: Response<T>, request: NSURLRequest) -> Void)?) -> Self {
        if successCodes.count > 0 { self.successCodes(successCodes) }
        data.handlers.successHandler = { handler?(response: try Response(data: $0.body, response: $0.response, options: $0.options), request: $1) }
        return self
    }
    
}

//
//  Request+Handlers.swift
//  Request
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation
import Convertible

extension Request {
    
    public func failure(handler: ((error: ErrorType, request: NSURLRequest) -> Void)?) -> Self {
        data.handlers.failureHandler = handler
        return self
    }
    
    public func response<T : DataInitializable>(responseCodes: ResponseCodes..., handler: (response: Response<T>, request: NSURLRequest) -> Void) -> Self {
        data.handlers.responseHandlers.append((reduceResponseCodes(responseCodes), { handler(response: try Response(data: $0.body, response: $0.response, options: $0.options), request: $1) }))
        return self
    }
    
    public func response(responseCodes: ResponseCodes..., handler: (response: Response<NSData>, request: NSURLRequest) -> Void) -> Self {
        data.handlers.responseHandlers.append((reduceResponseCodes(responseCodes), handler))
        return self
    }
    
    public func start(handler: (request: NSURLRequest) -> Void) -> Self {
        data.handlers.startHandlers.append(handler)
        return self
    }
    
    public func progress(handler: (sent: Double, received: Double, request: NSURLRequest) -> Void) -> Self {
        data.handlers.progressHandlers.append(handler)
        return self
    }
    
    public func completion(handler: (response: Response<NSData>?, errors: [ErrorType], request: NSURLRequest) -> Void) -> Self {
        data.handlers.completionHandlers.append(handler)
        return self
    }
    
    public func error(handler: (error: ErrorType, request: NSURLRequest) -> Void) -> Self {
        data.handlers.errorHandlers.append(handler)
        return self
    }
    
    public func error<T : ErrorType>(handler: (error: T, request: NSURLRequest) -> Void) -> Self {
        data.handlers.errorHandlers.append { if let error = $0 as? T { handler(error: error, request: $1) } }
        return self
    }
    
}

internal func reduceResponseCodes(responseCodes: [ResponseCodes]) -> Set<Int> {
    return responseCodes.reduce(Set<Int>()) { $0.0.union($0.1.responseCodes) }
}
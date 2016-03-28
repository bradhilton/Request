//
//  Request+FoundationRequest.swift
//  Request
//
//  Created by Bradley Hilton on 2/6/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

extension Request {
    
    public func foundationRequest() throws -> NSURLRequest {
        let request = NSMutableURLRequest()
        request.URL = NSURL(string: url.string)
        request.cachePolicy = configuration.cachePolicy
        request.timeoutInterval = configuration.timeoutInterval
        request.mainDocumentURL = mainDocumentURL != nil ? NSURL(string: mainDocumentURL!.string) : nil
        request.networkServiceType = configuration.networkServiceType
        request.allowsCellularAccess = configuration.allowsCellularAccess
        request.HTTPMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.HTTPBody = try body?.serializeToDataWithOptions(options)
        request.HTTPShouldHandleCookies = configuration.shouldSetCookies
        request.HTTPShouldUsePipelining = configuration.shouldUsePipelining
        return request
    }
    
}
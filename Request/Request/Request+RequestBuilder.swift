//
//  Request+RequestBuilder.swift
//  Request
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

extension Request {
    
    internal func modifyRequest(handler: NSMutableURLRequest -> Void) -> Self {
        handler(data.request)
        return self
    }
    
    public func cachePolicy(cachePolicy: NSURLRequestCachePolicy) -> Self {
        return modifyRequest { $0.cachePolicy = cachePolicy }
    }
    
    public func timeoutInterval(timeoutInterval: NSTimeInterval) -> Self {
        return modifyRequest { $0.timeoutInterval = timeoutInterval }
    }
    
    public func mainDocumentUrl(mainDocumentUrl: NSURL?) -> Self {
        return modifyRequest { $0.mainDocumentURL = mainDocumentUrl }
    }
    
    public func networkServiceType(networkServiceType: NSURLRequestNetworkServiceType) -> Self {
        return modifyRequest { $0.networkServiceType = networkServiceType }
    }
    
    public func allowsCellularAccess(allowsCellularAccess: Bool) -> Self {
        return modifyRequest { $0.allowsCellularAccess = allowsCellularAccess }
    }
    
    public func method(method: Method) -> Self {
        return modifyRequest { $0.HTTPMethod = method.rawValue }
    }
    
    public func headers(headers: [String : String]?) -> Self {
        return modifyRequest { request in
            request.allHTTPHeaderFields?.keys.forEach {
                request.setValue(headers?[$0], forHTTPHeaderField: $0)
            }
            request.allHTTPHeaderFields = headers
        }
    }
    
    public func appendHeaders(headers: [String : String?]) -> Self {
        return modifyRequest {
            for (key, value) in headers {
                $0.setValue(value, forHTTPHeaderField: key)
            }
        }
    }
    
    public func shouldHandleCookies(shouldHandleCookies: Bool) -> Self {
        return modifyRequest { $0.HTTPShouldHandleCookies = shouldHandleCookies }
    }
    
    public func shouldUsePipelining(shouldUsePipelining: Bool) -> Self {
        return modifyRequest { $0.HTTPShouldUsePipelining = shouldUsePipelining }
    }
    
}
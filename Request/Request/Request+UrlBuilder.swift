//
//  Request+UrlBuilder.swift
//  Request
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

extension Request {
    
    internal var url: NSURL? {
        return data.request.URL
    }
    
    internal var components: NSURLComponents? {
        guard let url = data.request.URL else { return NSURLComponents() }
        return NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
    }
    
    internal func modifyComponents(handler: NSURLComponents -> Void) -> Self {
        guard let components = components else { return self }
        handler(components)
        return self.components(components)
    }
    
    public func url(url: NSURL) -> Self {
        data.request.URL = url
        return self
    }
    
    public func absoluteString(string: String) -> Self {
        data.request.URL = NSURL(string: string)
        return self
    }
    
    public func components(components: NSURLComponents) -> Self {
        guard let url = components.URL else { return self }
        return self.url(url)
    }
    
    public func scheme(scheme: String) -> Self {
        return modifyComponents { $0.scheme = scheme }
    }
    
    public func user(user: String?) -> Self {
        return modifyComponents { $0.user = user }
    }
    
    public func password(password: String?) -> Self {
        return modifyComponents { $0.password = password }
    }
    
    public func host(host: String) -> Self {
        return modifyComponents { $0.host = host }
    }
    
    public func port(port: Int?) -> Self {
        return modifyComponents {
            if let port = port {
                $0.port = NSNumber(integer: port)
            } else {
                $0.port = nil
            }
        }
    }
    
    public func path(path: String?) -> Self {
        return modifyComponents { $0.path = path }
    }
    
    public func appendPath(path: String) -> Self {
        return modifyComponents { $0.path = $0.path != nil ? $0.path! + path : path }
    }
    
    public func query(query: String?) -> Self {
        return modifyComponents { $0.query = query }
    }
    
    public func appendQuery(query: String) -> Self {
        return modifyComponents {
            if let originalQuery = $0.query where !originalQuery.isEmpty {
                $0.query = "\(originalQuery)&\(query)"
            } else {
                $0.query = query
            }
        }
    }
    
    public func queryItems(queryItems: QueryItems?) -> Self {
        return modifyComponents { $0.queryItems = queryItems?.foundationQueryItems }
    }
    
    public func appendQueryItems(queryItems: QueryItems) -> Self {
        return modifyComponents {
            if let originalQueryItems = $0.queryItems {
                $0.queryItems = originalQueryItems + queryItems.foundationQueryItems
            } else {
                $0.queryItems = queryItems.foundationQueryItems
            }
        }
    }
    
    public func fragment(fragment: String?) -> Self {
        return modifyComponents { $0.fragment = fragment }
    }
    
}
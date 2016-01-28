//
//  Logging.swift
//  Request
//
//  Created by Bradley Hilton on 1/25/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

struct Logging {
    
    static func logRequest(request: NSURLRequest) {
        if let method = request.HTTPMethod, url = request.URL?.absoluteString {
                print("\n---> \(method) \(url)")
                printHeaderFields(request.allHTTPHeaderFields)
                printBody(request.HTTPBody)
                print("---> END " + bytesDescription(request.HTTPBody))
        }
    }
    
    static func logResponse(response: NSHTTPURLResponse, request: NSURLRequest, responseTime: NSTimeInterval, data: NSData) {
        if let method = request.HTTPMethod, url = request.URL?.absoluteString {
            print("\n<--- \(method) \(url) (\(response.statusCode), \(responseTimeDescription(responseTime)))")
            printHeaderFields(response.allHeaderFields)
            printBody(data)
            print("<--- END " + bytesDescription(data))
        }
    }
    
    private static func responseTimeDescription(responseTime: NSTimeInterval) -> NSString {
        return NSString(format: "%0.2fs", responseTime)
    }
    
    private static func printHeaderFields(headerFields: [NSObject : AnyObject]?) {
        if let headerFields = headerFields {
            for (field, value) in headerFields {
                print("\(field): \(value)")
            }
        }
    }
    
    private static func printBody(data: NSData?) {
        if let body = data,
            let bodyString = NSString(data: body, encoding: NSUTF8StringEncoding) where bodyString.length > 0 {
                print(bodyString)
        }
    }
    
    private static func bytesDescription(data: NSData?) -> String {
        return "(\(data != nil ? data!.length : 0) bytes)"
    }
    
}
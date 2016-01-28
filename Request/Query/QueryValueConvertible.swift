//
//  QueryValueConvertible.swift
//  Request
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

public protocol QueryValueConvertible {
    
    var queryValue: String { get }
    
}

extension QueryValueConvertible {
    
    public var queryValue: String {
        return String(self)
    }
    
}

extension String : QueryValueConvertible {}
extension Int : QueryValueConvertible {}
extension Bool : QueryValueConvertible {}

extension Array : QueryValueConvertible {
    
    public var queryValue: String {
        return map { element -> String in
            if let element = element as? QueryValueConvertible {
                return element.queryValue
            } else {
                return String(element)
            }
        }.joinWithSeparator(",")
    }
    
}

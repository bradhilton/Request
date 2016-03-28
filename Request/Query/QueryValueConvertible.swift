//
//  QueryValueConvertible.swift
//  Request
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

public protocol QueryValueSerializable {
    
    var queryValue: String { get }
    
}

extension QueryValueSerializable {
    
    public var queryValue: String {
        return String(self)
    }
    
}

extension String : QueryValueSerializable {}
extension Int : QueryValueSerializable {}
extension Bool : QueryValueSerializable {}

extension Array : QueryValueSerializable {
    
    public var queryValue: String {
        return map { element -> String in
            if let element = element as? QueryValueSerializable {
                return element.queryValue
            } else {
                return String(element)
            }
        }.joinWithSeparator(",")
    }
    
}

//
//  QueryItems.swift
//  Request
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

public struct QueryItems : DictionaryLiteralConvertible {
    
    private var items: [(String, QueryValueConvertible?)]
    
    internal var foundationQueryItems: [NSURLQueryItem] {
        var foundationQueryItems = [NSURLQueryItem]()
        items.forEach {
            foundationQueryItems.append(NSURLQueryItem(name: $0, value: $1?.queryValue))
        }
        return foundationQueryItems
    }
    
    public init(dictionaryLiteral elements: (String, QueryValueConvertible?)...) {
        self.items = elements
    }
    
}

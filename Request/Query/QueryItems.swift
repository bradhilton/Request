//
//  QueryItems.swift
//  Request
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

public struct QueryItems : DictionaryLiteralConvertible {
    
    internal var items: [QueryItem]
    
    public init(dictionaryLiteral elements: (String, QueryValueSerializable?)...) {
        self.items = elements.map { QueryItem(name: $0, value: $1) }
    }
    
}

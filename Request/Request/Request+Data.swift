//
//  Request.Data.swift
//  Request
//
//  Created by Bradley Hilton on 1/25/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation
import Convertible

extension Request {
    
    internal struct Data {
        
        var request = NSMutableURLRequest()
        var body: DataSerializable?
        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var queue: NSOperationQueue?
        var handlers = Handlers()
        var options = [ConvertibleOption]()
        var logging = false
        
        var copy: Data {
            return Data(request: request.mutableCopy() as! NSMutableURLRequest,
                body: body,
                configuration: configuration.copy() as! NSURLSessionConfiguration,
                queue: queue != nil ? queue?.copy() as? NSOperationQueue : nil,
                handlers: handlers,
                options: options,
                logging: logging)
        }
        
    }
    
}
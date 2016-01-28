//
//  Handlers.swift
//  Request
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

typealias StartHandler = (request: NSURLRequest) -> Void
typealias ProgressHandler = (sent: Double, received: Double, request: NSURLRequest) -> Void
typealias ErrorHandler = (error: ErrorType, request: NSURLRequest) -> Void
typealias ResponseHandler = (response: Response<NSData>, request: NSURLRequest) throws -> Void
typealias CompletionHandler = (response: Response<NSData>?, errors: [ErrorType], request: NSURLRequest) -> Void

struct Handlers {
    
    var successCodes = (200..<300).responseCodes
    
    var successHandler: ResponseHandler?
    var failureHandler: ErrorHandler?
    
    var startHandlers = [StartHandler]()
    var progressHandlers = [ProgressHandler]()
    var responseHandlers = [(Set<Int>, ResponseHandler)]()
    var errorHandlers = [ErrorHandler]()
    var completionHandlers = [CompletionHandler]()
    
}

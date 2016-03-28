//
//  TaskDelegate.swift
//  Request
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

internal class TaskDelegate : NSObject, NSURLSessionDataDelegate {
    
    var request: Request
    let body = NSMutableData()
    var response: Response<NSData>?
    var errors = [ErrorType]()
    var startTime = NSDate()
    var sent = 0.0 { didSet { if oldValue != sent { reportProgress() } } }
    var received = 0.0 { didSet { if oldValue != received { reportProgress() } } }
    
    init(request: Request) {
        self.request = request
        super.init()
    }
    
    func task() -> NSURLSessionTask {
        request.callbacks.reportStart(request)
        reportProgress()
        do {
            return try startTask(request.foundationRequest())
        } catch {
            return failedTaskWithError(error)
        }
    }
    
    func handleError(error: ErrorType) {
        errors.append(error)
        request.callbacks.reportFailure(error, request: request)
        request.callbacks.failureCallback = nil
        request.callbacks.reportError(error, request: request)
    }
    
    func complete(response: Response<NSData>?) {
        if let response = response {
            for error in request.callbacks.reportResponse(response, request: request) {
                handleError(error)
            }
        }
        request.callbacks.reportCompletion(response, errors: errors, request: request)
    }
    
    private func failedTaskWithError(error: ErrorType) -> NSURLSessionTask {
        handleError(error)
        complete(nil)
        return FailedTask()
    }
    
    private func startTask(foundationRequest: NSURLRequest) -> NSURLSessionTask {
        let session = NSURLSession(configuration: request.configuration.foundationConfiguration, delegate: self, delegateQueue: NSOperationQueue())
        let task = session.dataTaskWithRequest(foundationRequest)
        task.resume()
        request.logging ? Logging.logRequest(foundationRequest) : ()
        startTime = NSDate()
        session.finishTasksAndInvalidate()
        return task
    }
    
    private func reportProgress() {
        request.callbacks.reportProgress(sent, received: received, request: request)
    }
    
}
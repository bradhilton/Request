//
//  TaskDelegate.swift
//  Request
//
//  Created by Bradley Hilton on 1/21/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

internal class TaskDelegate : NSObject, NSURLSessionDataDelegate {
    
    var data: Request.Data
    let body = NSMutableData()
    var response: Response<NSData>?
    var errors = [ErrorType]()
    var startTime = NSDate()
    var sent = 0.0 { didSet { if oldValue != sent { reportProgress() } } }
    var received = 0.0 { didSet { if oldValue != received { reportProgress() } } }
    
    init(data: Request.Data) {
        self.data = data
        super.init()
    }
    
    func task() -> NSURLSessionTask {
        let error = serializeData()
        data.handlers.startHandlers.forEach { $0(request: self.data.request) }
        reportProgress()
        if let error = error {
            return failedTaskWithError(error)
        } else {
            return startTask()
        }
    }
    
    func handleError(error: ErrorType) {
        errors.append(error)
        data.handlers.failureHandler?(error: error, request: data.request)
        data.handlers.failureHandler = nil
        data.handlers.errorHandlers.forEach { $0(error: error, request: data.request) }
    }
    
    func complete(response: Response<NSData>?) {
        if let response = response {
            handleResponse(response)
        }
        data.handlers.completionHandlers.forEach {
            $0(response: response, errors: errors, request: data.request)
        }
    }
    
    private func handleResponse(response: Response<NSData>) {
        data.handlers.responseHandlers.forEach {
            guard $0.contains(response.statusCode) else { return }
            do {
                try $1(response: response, request: data.request)
            } catch {
                handleError(error)
            }
        }
    }
    
    private func serializeData() -> ErrorType? {
        do {
            data.request.HTTPBody = try data.body?.serializeToData()
            return nil
        } catch {
            return error
        }
    }
    
    private func failedTaskWithError(error: ErrorType) -> NSURLSessionTask {
        handleError(error)
        complete(nil)
        return FailedTask()
    }
    
    private func startTask() -> NSURLSessionTask {
        let session = NSURLSession(configuration: data.configuration, delegate: self, delegateQueue: data.queue)
        let task = session.dataTaskWithRequest(data.request)
        task.resume()
        data.logging ? Logging.logRequest(data.request) : ()
        startTime = NSDate()
        session.finishTasksAndInvalidate()
        return task
    }
    
    private func reportProgress() {
        data.handlers.progressHandlers.forEach { $0(sent: sent, received: received, request: data.request) }
    }
    
}
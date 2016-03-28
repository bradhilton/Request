//
//  TaskDelegate+NSURLSessionDataTaskDelegate.swift
//  Request
//
//  Created by Bradley Hilton on 1/25/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

extension TaskDelegate {
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        sent = progress(task.countOfBytesSent, expected: task.countOfBytesExpectedToSend)
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        sent = 1.0
        completionHandler(.Allow)
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        received = progress(dataTask.countOfBytesReceived, expected: dataTask.countOfBytesExpectedToReceive)
        body.appendData(data)
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        var response: Response<NSData>?
        do {
            if let error = error { throw error }
            received = 1.0
            let foundationResponse = try self.foundationResponse(task)
            let responseTime = NSDate().timeIntervalSinceDate(startTime)
            request.logging ? Logging.logResponse(foundationResponse, request: request, responseTime: responseTime, data: body) : ()
            response = Response(body: body as NSData, foundationResponse: foundationResponse, responseTime: responseTime, options: request.options)
            try request.callbacks.reportSuccess(response!, request: request)
        } catch {
            handleError(error)
        }
        complete(response)
    }
    
    private func foundationResponse(task: NSURLSessionTask) throws -> NSHTTPURLResponse {
        guard let foundationResponse = task.response as? NSHTTPURLResponse else {
            throw UnknownError(description: "Task did not return NSHTTPURLResponse")
        }
        return foundationResponse
    }
    
    private func progress(actual: Int64, expected: Int64) -> Double {
        return expected != 0 ? Double(actual)/Double(expected) : 1
    }
    
}
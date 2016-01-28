//
//  GenericRequest.swift
//  Request
//
//  Created by Bradley Hilton on 1/25/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation
import Convertible

public class GenericRequest<ResponseType : DataInitializable> : Request {
    
    class var method: Method { return .GET }
    
    public override init(_ request: Request) {
        super.init(request)
        self.method(self.dynamicType.method)
    }
    
    public override init(_ absoluteString: String) {
        super.init(absoluteString)
        self.method(self.dynamicType.method)
    }
    
    override public func success(successCodes: ResponseCodes..., handler: ((response: Response<ResponseType>, request: NSURLRequest) -> Void)?) -> Self {
        if successCodes.count > 0 { self.successCodes(successCodes) }
        data.handlers.successHandler = { handler?(response: try Response(data: $0.body, response: $0.response, options: $0.options), request: $1) }
        return self
    }
    
}

public class GET<ResponseType : DataInitializable> : GenericRequest<ResponseType> {
    override class var method: Method { return .GET }
    public override init(_ request: Request) { super.init(request) }
    public override init(_ absoluteString: String) { super.init(absoluteString) }
}

public class POST<ResponseType : DataInitializable> : GenericRequest<ResponseType> {
    override class var method: Method { return .POST }
    public override init(_ request: Request) { super.init(request) }
    public override init(_ absoluteString: String) { super.init(absoluteString) }
}

public class PUT<ResponseType : DataInitializable> : GenericRequest<ResponseType> {
    override class var method: Method { return .PUT }
    public override init(_ request: Request) { super.init(request) }
    public override init(_ absoluteString: String) { super.init(absoluteString) }
}

public class DELETE<ResponseType : DataInitializable> : GenericRequest<ResponseType> {
    override class var method: Method { return .DELETE }
    public override init(_ request: Request) { super.init(request) }
    public override init(_ absoluteString: String) { super.init(absoluteString) }
}

public class PATCH<ResponseType : DataInitializable> : GenericRequest<ResponseType> {
    override class var method: Method { return .PATCH }
    public override init(_ request: Request) { super.init(request) }
    public override init(_ absoluteString: String) { super.init(absoluteString) }
}
//
//  Task.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

public final class Task <Response, Error> {
    public typealias Initializer = (_: @escaping (APIResult<Response>) -> Void) -> Void
    private var response : ((APIResult<Response>) -> Void)?
    private var initializer: Initializer?
    
    public func response (handler : @escaping (APIResult <Response>) -> Void) -> Self{
        response = handler
        return self
    }
    
    public init(initClosure: @escaping Initializer) {
        initializer = initClosure
        executeRequest()
    }
    
    private func executeRequest() {
        initializer?({ result in
            
            switch result {
            case let .response(data):
                self.response?(APIResult.response(data))
            case let .error(data):
                self.response?(APIResult.error(data))
            }
        })
    }
}

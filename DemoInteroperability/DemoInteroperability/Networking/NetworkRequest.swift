//
//  NetworkRequest.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

protocol NetworkRequest : class {
    associatedtype Model
    func load (withCompletion completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)
}

//
//  APIRequest.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

final class APIRequest <Resource : APIResource> {
    let resource : Resource
    
    init(resource : Resource) {
        self.resource = resource
    }
}

extension APIRequest : NetworkRequest {
    typealias Model = Resource.Model

    func load(withCompletion completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        guard let request = resource.request else {
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        
        print("Requested URL: \(request)")
        
        let task = session.dataTask(with: request) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard self != nil else {
                completion(nil, nil, error)
                return
            }
            
            return completion(data, response, error)
        }
        task.resume()
    }
}

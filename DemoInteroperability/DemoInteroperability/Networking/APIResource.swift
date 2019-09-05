//
//  APIResource.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

protocol APIResource {
    associatedtype Model
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var parameter: APIParameter { get }
}

extension APIResource {
    var request : URLRequest? {
        let urlString = baseURL + path
        
        switch method {
        case .get:
            guard var components = URLComponents(string: urlString) else{
                return nil
            }
            guard let parameter = parameter as? GETAPIParameter else{
                return nil
            }
            
            components.queryItems = parameter.makeQueryItem()

            var urlRequest = URLRequest (url: components.url!)
            urlRequest.httpMethod = method.rawValue
            return urlRequest
            
        case .post:
            guard let url = URL (string: urlString) else {
                return nil
            }
            
            guard let parameter = parameter as? POSTAPIParameter else {
                return nil
            }
            
            var urlRequest = URLRequest (url: url)
            let parameterString = parameter.makeParameterString()
            if !parameterString.isEmpty{
                urlRequest.httpBody = parameterString.data(using: .utf8)
            }
            
            urlRequest.httpMethod = method.rawValue
            return urlRequest
        }
    }
}

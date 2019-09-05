//
//  APIParameter.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

protocol ParamKey {
    var stringValue: String { get }
}

extension RawRepresentable where RawValue == String {
    var stringValue: String {
        return rawValue
    }
}

protocol APIParameter {
    var properties:Array<ParamKey> { get }
    func valueForKey(key: ParamKey) -> Any?
    func toDictionary() -> [String:Any]
}

protocol GETAPIParameter: APIParameter {
    func makeQueryItem() -> [URLQueryItem]
}

protocol POSTAPIParameter: APIParameter {
    func makeParameterString() -> String
}

extension APIParameter {
    func toDictionary() -> [String:Any] {
        
        var dict:[String:Any] = [:]
        
        for prop in self.properties {
            if let val = self.valueForKey(key: prop) as? String {
                dict[prop.stringValue] = val
            } else if let val = self.valueForKey(key: prop) as? Int {
                dict[prop.stringValue] = val
            } else if let val = self.valueForKey(key: prop) as? Double {
                dict[prop.stringValue] = val
            } else if let val = self.valueForKey(key: prop) as? Array<String> {
                dict[prop.stringValue] = val
            } else if let val = self.valueForKey(key: prop) as? APIParameter {
                dict[prop.stringValue] = val.toDictionary()
            } else if let val = self.valueForKey(key: prop) as? Array<APIParameter> {
                var arr = Array<[String:Any]>()
                
                for item in (val as Array<APIParameter>) {
                    arr.append(item.toDictionary())
                }
                
                dict[prop.stringValue] = arr
            }
        }
        return dict
    }
}

extension GETAPIParameter {
    func makeQueryItem() -> [URLQueryItem] {
        var items:[URLQueryItem] = []
        let parameter: [String:Any] = self.toDictionary()
        parameter.forEach { key, value in
            let string = String(describing: value)
            guard !string.isEmpty else { return }
            items.append(URLQueryItem(name: key, value: string.URLEscaped))
        }
        return items
    }
}

extension POSTAPIParameter {
    func makeParameterString() -> String {
        let parameter: [String:Any] = self.toDictionary()
        return parameter.enumerated().reduce("?") { (input, tuple) in
            switch tuple.element.value {
            case let string as String:
                guard string.isEmpty else { return "" }
                return input + tuple.element.key + "=" + string
            default:
                return input + tuple.element.key + "=" + String(describing: tuple.element.value)
            }
        }
    }
}

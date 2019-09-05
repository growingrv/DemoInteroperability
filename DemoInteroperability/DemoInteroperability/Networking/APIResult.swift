//
//  APIResult.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

public enum APIResult <T> {
    case response(T)
    case error(Error)
}

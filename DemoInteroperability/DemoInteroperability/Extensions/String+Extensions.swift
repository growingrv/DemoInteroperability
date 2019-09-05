//
//  String+Extensions.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 30/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: .main, value: "", comment: "")
    }
    
    var URLEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}

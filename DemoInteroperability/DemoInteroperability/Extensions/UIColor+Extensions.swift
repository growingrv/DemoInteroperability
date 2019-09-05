//
//  UIColor+Extensions.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 02/08/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit

extension UIColor {
    // Gray
    func customColor1() -> UIColor {
       return UIColor.init(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
    }
    
    // Blue
    func customColor2() -> UIColor {
       return UIColor.init(red: 64.0/255.0, green: 166.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    }

    // Yellow
    func customColor3() -> UIColor {
        return UIColor.init(red: 244.0/255.0, green: 183.0/255.0, blue: 64.0/255.0, alpha: 1.0)
    }

}

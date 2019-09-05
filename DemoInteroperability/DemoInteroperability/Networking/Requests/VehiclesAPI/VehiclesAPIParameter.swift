//
//  VehiclesParameter.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

final class VehiclesAPIParameter : APIParameter {
    let p1Lat: Double
    let p1Long: Double
    let p2Lat: Double
    let p2Long: Double

    init(p1Lat: Double, p1Long: Double, p2Lat: Double, p2Long: Double) {
        self.p1Lat = p1Lat
        self.p1Long = p1Long
        self.p2Lat = p2Lat
        self.p2Long = p2Long
    }
}

extension VehiclesAPIParameter: GETAPIParameter {
    enum Keys: String, ParamKey {
        case p1Lat
        case p1Lon
        case p2Lat
        case p2Lon
    }
    
    var properties: Array<ParamKey> {
        return [Keys.p1Lat, Keys.p1Lon, Keys.p2Lat, Keys.p2Lon]
    }
    
    func valueForKey(key: ParamKey) -> Any? {
        switch key {
        case Keys.p1Lat:
            return p1Lat
        case Keys.p1Lon:
            return p1Long
        case Keys.p2Lat:
            return p2Lat
        case Keys.p2Lon:
            return p2Long
        default:
            return nil
        }
    }
}

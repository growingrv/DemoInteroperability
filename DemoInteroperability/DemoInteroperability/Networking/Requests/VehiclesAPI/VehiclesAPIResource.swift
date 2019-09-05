//
//  VehiclesResource.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

final class VehiclesAPIResource : APIResource {
    init(p1Lat: Double, p1Long: Double, p2Lat: Double, p2Long: Double) {
        self.parameter = VehiclesAPIParameter (p1Lat: p1Lat, p1Long: p1Long, p2Lat: p2Lat, p2Long: p2Long)
    }
    
    typealias Model = [Vehicle]
    
    var baseURL : String {
        return "https://fake-poi-api.mytaxi.com"
    }
    
    var path : String {
        return ""
    }
    
    var method : HttpMethod {
        return .get
    }
    
    // just for reference, not to be used
    var mainURL : String {
        return "https://fake-poi-api.mytaxi.com/?p2Lat=53.394655&p1Lon=9.757589&p1Lat=53.694865&p2Lon=10.099891"
    }

    let parameter : APIParameter
}

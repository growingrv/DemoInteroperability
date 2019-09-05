//
//  ResponseKeys.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

enum VehicleAPIResponseKeys: String  {
    case vehiclePOIList = "poiList"
    case vehicleFleetType = "fleetType"
    case vehicleHeading = "heading"
    case vehicleID = "id"
    case vehicleCoordinate = "coordinate"
    case vehicleLatitude = "latitude"
    case vehicleLongitude = "longitude"

    var key: String {
        return self.rawValue
    }
}

enum VehicleAPIResponseValues: String  {
    case vehicleFleetTypeTaxi = "TAXI"
    case vehicleFleetTypePooling = "POOLING"
    
    var value: String {
        return self.rawValue
    }
}



//
//  VehicleTest.swift
//  DemoInteroperabilityTests
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import XCTest
@testable import DemoInteroperability

class VehicleTest: XCTestCase {

    func testVehicleFleetTypePooling() {
        
        // Arranging values
        let id = 164767
        let latitude = 53.48011042560974
        let longitude = 9.830760168723184
        let fleetType = "POOLING"
        let heading = 262.8985338722198
        let dictVehicle = ["id":id, "coordinate":["latitude":latitude,"longitude":longitude], "fleetType": fleetType, "heading": heading ] as [String : Any]
        
        // Acing on values
        let vehicle = Vehicle(dictVehicle: dictVehicle as Dictionary<String, AnyObject>)
        
        // Asserting
        XCTAssertEqual(vehicle?.vehicleIdentifier, id)
        XCTAssertEqual(vehicle?.vehicleCoordinates.latitude, latitude)
        XCTAssertEqual(vehicle?.vehicleCoordinates.longitude, longitude)
        XCTAssertEqual(vehicle?.vehicleFleetType, VehicleAPIResponseValues.vehicleFleetTypePooling.rawValue)
        XCTAssertEqual(vehicle?.vehicleHeading, heading)
    }
    
    func testVehicleFleetTypeTaxi() {
        
        // Arranging values
        let id = 316470
        let latitude = 53.58674786386291
        let longitude = 10.00642787283115
        let fleetType = "TAXI"
        let heading = 152.5790793065766
        let dictVehicle = ["id":id, "coordinate":["latitude":latitude,"longitude":longitude], "fleetType": fleetType, "heading": heading ] as [String : Any]
        
        // Acing on values
        let vehicle = Vehicle(dictVehicle: dictVehicle as Dictionary<String, AnyObject>)

        // Asserting
        XCTAssertEqual(vehicle?.vehicleIdentifier, id)
        XCTAssertEqual(vehicle?.vehicleCoordinates.latitude, latitude)
        XCTAssertEqual(vehicle?.vehicleCoordinates.longitude, longitude)
        XCTAssertEqual(vehicle?.vehicleFleetType, VehicleAPIResponseValues.vehicleFleetTypeTaxi.rawValue)
        XCTAssertEqual(vehicle?.vehicleHeading, heading)
    }
}


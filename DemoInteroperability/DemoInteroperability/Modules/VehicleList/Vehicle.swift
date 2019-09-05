//
//  Vehicle.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 24/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

// Ideally, Vehicle & VehicleList should be of type Struct, but Vehicle & VehicleList are used in Objective C module as well (to enhance code reusability & to avoid code duplicacy). Hence, they are made of type Class.
// i.e. VehicleList is being used in VehicleAPI's fetchVehicles method, hence we need to make VehicleList type compatible to Objective C .

// struct Vehicle {
@objc class Vehicle : NSObject {

    @objc var vehicleHeading : Double
    @objc var vehicleIdentifier : Int
    @objc var vehicleFleetType : String
    @objc var vehicleCoordinates : VehicleCoordinates = VehicleCoordinates (latitude: 0.0, longitude: 0.0)
    var vehicleDistanceFromHamburg : Double = 0

    init?(dictVehicle: Dictionary<String, AnyObject>) {
        self.vehicleHeading = dictVehicle[VehicleAPIResponseKeys.vehicleHeading.key] as! Double
        self.vehicleIdentifier = dictVehicle[VehicleAPIResponseKeys.vehicleID.key] as! Int
        self.vehicleFleetType = dictVehicle[VehicleAPIResponseKeys.vehicleFleetType.key] as? String ?? ""
        super.init()
        if let coordinate = dictVehicle[VehicleAPIResponseKeys.vehicleCoordinate.key] as? Dictionary<String, AnyObject>{
              self.vehicleCoordinates = getCoordinate(coordinate: coordinate)
        }
        vehicleDistanceFromHamburg = Utilities.shared.distanceBetweenPoints(p1Lat: vehicleCoordinates.latitude, p1Long: vehicleCoordinates.longitude, p2Lat: Coordinates.Hamburg.latitude, p2Long: Coordinates.Hamburg.longitude)
    }
}

// struct VehicleList {
@objc class VehicleList : NSObject {
    
    @objc public var vehicles = [Vehicle]()
    
    init(vehiclesTemp: [Any]) {
        vehicles = vehiclesTemp.compactMap() { dict in
            if let typeDict = dict as? Dictionary<String,AnyObject>{
                return Vehicle(dictVehicle: typeDict)
            }
            else {
                return nil
            }
        }
    }
}

extension Vehicle {
    private func getCoordinate(coordinate: Dictionary<String,AnyObject>) -> VehicleCoordinates {
        let coordinate = VehicleCoordinates(latitude: coordinate[VehicleAPIResponseKeys.vehicleLatitude.key] as? Double ?? 0.0, longitude: coordinate[VehicleAPIResponseKeys.vehicleLongitude.key] as? Double ?? 0.0)
        return coordinate
    }
}

@objc class VehicleCoordinates : NSObject {
    @objc let latitude : Double
    @objc let longitude : Double
    
    init(latitude : Double, longitude : Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

/*
 struct VehicleCoordinates {
    let latitude : Double
    let longitude : Double
 }
 */

//
//  Utilities.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 24/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

@objc class Utilities: NSObject {
    @objc static let shared = Utilities()
    let activity = UIActivityIndicatorView(style: .gray)
    
    func sortVehicles(vehicles : [Vehicle]) -> [Vehicle] {
        if (vehicles.count > 0) {
            let sortedArray = vehicles.sorted {
                $0.vehicleDistanceFromHamburg < $1.vehicleDistanceFromHamburg
            }
            return sortedArray
        }
        return vehicles
    }
    
    func filterVehicles(vehicles : [Vehicle], vehicleType : VehicleType) -> [Vehicle] {
        var filterArray = [Vehicle]()
        
        switch vehicleType {
        case .all:
            filterArray = vehicles
        case .taxis:
            filterArray = vehicles.filter {
                $0.vehicleFleetType == VehicleAPIResponseValues.vehicleFleetTypeTaxi.value
            }
        case .pools:
            filterArray = vehicles.filter {
                $0.vehicleFleetType == VehicleAPIResponseValues.vehicleFleetTypePooling.value
            }
        }

        return sortVehicles(vehicles: filterArray)
    }
    
    func distanceBetweenPoints(p1Lat: Double, p1Long: Double, p2Lat: Double, p2Long: Double) -> Double {
        let userloc = CLLocation(latitude: p1Lat, longitude: p1Long)
        let dest = CLLocation(latitude: p2Lat, longitude: p2Long)
        return Double(userloc.distance(from: dest))/1000
    }
    
    @objc func getHamburgRegion() ->  MKCoordinateRegion{
        let startCoord = CLLocationCoordinate2DMake(Coordinates.Hamburg.latitude, Coordinates.Hamburg.longitude)
        let viewRegion = MKCoordinateRegion(center: startCoord, latitudinalMeters: 20000, longitudinalMeters: 20000)
        return viewRegion
    }
    
    @objc func showAlert(title : String?, message : String?) -> UIAlertController{
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overCurrentContext
        alertController.addAction(UIAlertAction (title: "Ok", style: .default, handler: nil))
        return alertController
    }
}

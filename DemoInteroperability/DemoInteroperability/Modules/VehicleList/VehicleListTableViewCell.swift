//
//  VehicleListTableViewCell.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 31/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit
import CoreLocation

class VehicleListTableViewCell: UITableViewCell {
    @IBOutlet weak var vehicleImageView: UIImageView!
    @IBOutlet weak var vehicleDriverNameLabel: UILabel!
    @IBOutlet weak var vehicleDistanceLabel: UILabel!
    @IBOutlet weak var vehicleTypeLabel: RoundedCornerLabel!
    
    func displayCellDetails(vehicle: Vehicle) {
        if (vehicle.vehicleFleetType == VehicleAPIResponseValues.vehicleFleetTypeTaxi.rawValue){
            vehicleTypeLabel?.text = VehicleTypeDisplay.taxi.uppercased()
        }
        if (vehicle.vehicleFleetType == VehicleAPIResponseValues.vehicleFleetTypePooling.rawValue){
            vehicleTypeLabel.text = VehicleTypeDisplay.pool.uppercased()
        }
        vehicleDriverNameLabel?.text = "Oliver Tremblay"
        vehicleDistanceLabel?.text = "\(String(format: "%.1f", vehicle.vehicleDistanceFromHamburg ))" + " km away"
    }
}

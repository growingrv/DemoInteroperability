//
//  VehicleListDataSource.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 24/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit

class VehicleListDataSource: NSObject, UITableViewDataSource {
    var vehicles = [Vehicle]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : VehicleListTableViewCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.StoryboardIdentifiers.vehicleTableViewCellID, for: indexPath) as! VehicleListTableViewCell
        cell.displayCellDetails(vehicle: vehicles[indexPath.row])
        return cell
    }
}

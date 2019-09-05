//
//  VehicleListDataSourceTest.swift
//  DemoInteroperabilityTests
//
//  Created by Gaurav Tiwari on 03/08/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import XCTest
@testable import DemoInteroperability

class VehicleListDataSourceTest: XCTestCase {
    
    var vehicleListDataSource : VehicleListDataSource!
    
    override func setUp() {
        super.setUp()
        vehicleListDataSource = VehicleListDataSource()
    }
    
    override func tearDown() {
        vehicleListDataSource = nil
        super.tearDown()
    }
    
    func testEmptyValueInDataSource() {
        // giving empty data value
        vehicleListDataSource.vehicles = []
        
        let tableView = UITableView()
        tableView.dataSource = vehicleListDataSource
        
        // expected one section
        XCTAssertEqual(tableView.numberOfSections, 1, "Expected one section in table view")
        
        // expected zero cells
        XCTAssertEqual(vehicleListDataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }
    
    func testValueInDataSource() {
        
        // giving data values
        let dictVehicle1 = ["heading":262.8985338722198, "fleetType": "TAXI", "coordinate" : ["latitude":53.48011042560974, "longitude": 9.830760168723184],"id": 164767] as [String : Any]
        let dictVehicle2 = ["heading":152.5790793065766, "fleetType": "TAXI", "coordinate" : ["latitude":53.58674786386291, "longitude": 10.00642787283115],"id": 316470] as [String : Any]
        
        let vechicle1 = Vehicle(dictVehicle: dictVehicle1 as Dictionary<String, AnyObject>)
        let vechicle2 = Vehicle(dictVehicle: dictVehicle2 as Dictionary<String, AnyObject>)

        vehicleListDataSource.vehicles = [vechicle1, vechicle2] as! [Vehicle]
        
        let tableView = UITableView()
        tableView.dataSource = vehicleListDataSource

        // expected one section
        XCTAssertEqual(tableView.numberOfSections, 1, "Expected one section in table view")

        // expected two cells
        XCTAssertEqual(vehicleListDataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
    }
    
    func testValueForCell() {
        
        // giving data value
        let dictVehicle = ["heading":262.8985338722198 as AnyObject, "fleetType": "TAXI" as AnyObject, "coordinate" : ["latitude":53.48011042560974, "longitude": 9.830760168723184],"id": 164767] as [String : Any]

        let vechicle = Vehicle(dictVehicle: dictVehicle as Dictionary<String, AnyObject>)
        
        vehicleListDataSource.vehicles = [vechicle] as! [Vehicle]
        
        let tableView = UITableView()
        tableView.dataSource = vehicleListDataSource
        tableView.register(VehicleListTableViewCell.self, forCellReuseIdentifier: Identifiers.StoryboardIdentifiers.vehicleTableViewCellID)
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        // expected VehicleListTableViewCell class
        guard let _ = vehicleListDataSource.tableView(tableView, cellForRowAt: indexPath) as? VehicleListTableViewCell else {
            XCTAssert(false, "Expected CurrencyCell class")
            return
        }
    }
}

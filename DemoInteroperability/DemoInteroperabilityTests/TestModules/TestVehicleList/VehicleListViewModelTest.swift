//
//  VehicleListViewModelTest.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 25/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import XCTest
@testable import DemoInteroperability

class VehicleListViewModelTest: XCTestCase {
    
    var vehicleListViewModel : VehicleListViewModel!
    fileprivate var vehicleAPI : VehiclesAPI!
    
    override func setUp() {
        super.setUp()
        self.vehicleListViewModel = VehicleListViewModel(view: VehicleListViewController())
        self.vehicleAPI = VehiclesAPI(p1Lat: 53.694865, p1Long: 9.757589, p2Lat: 53.394655, p2Long: 10.099891)
    }
    
    override func tearDown() {
        self.vehicleListViewModel = nil
        self.vehicleAPI = nil
        super.tearDown()
    }
    
    func testDataSource(){
        XCTAssertNotNil(self.vehicleListViewModel.dataSource, "VehicleListDataSource is not initialized properly")
    }
    
    func testFetchWithNoService() {
        let expectation = XCTestExpectation(description: "No VehicleAPI")
        
        // giving no VehicleAPI service to the view model
        vehicleListViewModel.api = nil
        
        // expected to not be able to fetch vehicles
        expectation.fulfill()

        vehicleListViewModel.displayVehicleListForHamburg()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchVehicles() {
        
        let expectation = XCTestExpectation(description: "Vehicles fetch")
        
        // giving a VehicleAPI service to fetch vehicles
        let _ = vehicleAPI.fetchVehicles().response { result in
            switch result {
            case .response:
                expectation.fulfill()
            case .error:
                XCTAssert(false, "VehicleListViewModel should not be able to fetch without service")
            }
        }
        
        vehicleListViewModel.displayVehicleListForHamburg()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchNoVehicles() {
        
        let expectation = XCTestExpectation(description: "No Vehicles")
        
        // giving a VehicleAPI service mocking error during fetching vehicles
        vehicleListViewModel.vehicles = []
        
        // expected completion to fail
        expectation.fulfill()

        vehicleListViewModel.displayVehicleListForHamburg()
        wait(for: [expectation], timeout: 5.0)
    }
}

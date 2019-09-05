//
//  VehicleListViewControllerTest.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 25/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import XCTest
@testable import DemoInteroperability

class VehicleListViewControllerTest: XCTestCase {
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }

    func testViewModel(){
        let storyboardBundle = Bundle(for: VehicleListViewController.self)
        let storyboard = UIStoryboard(name: Identifiers.StoryboardIdentifiers.main, bundle: storyboardBundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: Identifiers.StoryboardIdentifiers.vehicleListViewController) as! VehicleListViewController
        viewController.loadView()
        XCTAssertNotNil(viewController.vehicleListViewModel, "VehicleListViewModel is not initialized properly")
    }
    
    func testVehicleListTableView() {
        let storyboardBundle = Bundle(for: VehicleListViewController.self)
        let storyboard = UIStoryboard(name: Identifiers.StoryboardIdentifiers.main, bundle: storyboardBundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: Identifiers.StoryboardIdentifiers.vehicleListViewController) as! VehicleListViewController
        viewController.loadView()
        XCTAssertNotNil(viewController.vehicleTableView, "VehicleTableView is not initialized properly")
    }
}

//
//  VehicleListViewController.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 24/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit
class VehicleListViewController: UIViewController {
    @IBOutlet weak var vehicleTypeSegment: UISegmentedControl!
    @IBOutlet weak var vehicleTableView: UITableView!
    
    // Lazy initialization of viewModel property using lazy keyword is a good practice.
    lazy var vehicleListViewModel : VehicleListViewModel = {
        let vehicleListViewModel = VehicleListViewModel(view: self)
        return vehicleListViewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayVehicleListForHamburg()
    }
    
    private func displayVehicleListForHamburg(){
        vehicleListViewModel.displayVehicleListForHamburg()
    }
    
    // MARK: - IBAction
    @IBAction func vehicleTypeChanged(_ sender: Any) {
        vehicleListViewModel.vehicleTypeChanged(type: VehicleType(rawValue: self.vehicleTypeSegment.selectedSegmentIndex)!)
    }
}

// Following extension is used for conforming to UI related protocols. This helps in better code separation and organization.
// The requirements of following protocols are addressed in view's viewModel
extension VehicleListViewController : AlertShowable, Progressable {
    
}

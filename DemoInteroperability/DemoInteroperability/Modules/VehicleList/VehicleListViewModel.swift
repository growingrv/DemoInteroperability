//
//  VehicleListModel.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 24/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit

enum VehicleType : Int {
    case all = 0
    case taxis = 1
    case pools = 2
}

class VehicleListViewModel: NSObject {
    private weak var view : VehicleListViewController?
    var dataSource = VehicleListDataSource()
    var vehicles = [Vehicle]()
    internal var api : VehiclesAPI!

    init(view : VehicleListViewController) {
        self.view = view
        self.view?.vehicleTableView?.dataSource = dataSource
    }
    
    func displayVehicleListForHamburg() {
        showActivityUI()

        if (vehicles.count > 0){
            dataSource.vehicles = vehicles
            return
        }
        
        api = VehiclesAPI.init(p1Lat: Coordinates.HamburgP1.latitude, p1Long: Coordinates.HamburgP1.longitude, p2Lat: Coordinates.HamburgP2.latitude, p2Long: Coordinates.HamburgP2.longitude)

        let _ = api.fetchVehicles().response { [weak self] result in
            switch result {
            
            case .response (let vehiclesData):
                self?.vehicles = vehiclesData
                self?.dataSource.vehicles = Utilities.shared.sortVehicles(vehicles: self?.vehicles ?? [])
                self?.hideActivityUI()
                DispatchQueue.main.async {
                    self?.view?.vehicleTableView?.reloadData()
                }
                
            case .error (let error):
                self?.hideActivityUI()
                DispatchQueue.main.async {
                    self?.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func vehicleTypeChanged(type : VehicleType) {
        DispatchQueue.main.async {
            self.showActivityUI()
        }

        switch type {
        case .all:
            self.dataSource.vehicles = Utilities.shared.filterVehicles(vehicles: self.vehicles, vehicleType: .all)
        case .taxis:
            self.dataSource.vehicles = Utilities.shared.filterVehicles(vehicles: self.vehicles, vehicleType: .taxis)
        case .pools:
            self.dataSource.vehicles = Utilities.shared.filterVehicles(vehicles: self.vehicles, vehicleType: .pools)
        }
        
        DispatchQueue.main.async {
            self.hideActivityUI()
            self.view?.vehicleTableView.reloadData()
        }
    }
}

extension VehicleListViewModel {
    private func showActivityUI() {
        DispatchQueue.main.async {
            self.view?.showLoading()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    private func hideActivityUI() {
        DispatchQueue.main.async {
            self.view?.hideLoading()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}

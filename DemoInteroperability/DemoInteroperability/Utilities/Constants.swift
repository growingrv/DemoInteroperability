//
//  Coordinates.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 30/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

struct Identifiers {
    struct StoryboardIdentifiers {
        static let main = "Main"
        static let vehicleTableViewCellID = "vehicleListTableViewCell"
        static let vehicleListViewController = "VehicleListViewController"
    }
    struct SegueIdentifiers {
        static let show = ""
    }
}

struct Coordinates {
    struct Hamburg {
        static let latitude = 53.5511
        static let longitude = 9.9937
    }
    
    struct HamburgP1 {
        static let latitude = 53.694865
        static let longitude = 9.757589
    }
    
    struct HamburgP2 {
        static let latitude = 53.394655
        static let longitude = 10.099891
    }    
}

struct VehicleTypeDisplay {
    static let taxi = "TAXI"
    static let pool = "POOL"
}

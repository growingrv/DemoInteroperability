//
//  VehicleMapViewController.h
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicleMapViewModel.h"
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VehicleMapViewController : UIViewController
@property (strong, nonatomic) VehicleMapViewModel *vehicleMapViewModel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

NS_ASSUME_NONNULL_END

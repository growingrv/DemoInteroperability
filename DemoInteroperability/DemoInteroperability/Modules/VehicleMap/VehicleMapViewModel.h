//
//  VehicleMapViewModel.h
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "DemoInteroperability-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VehicleMapViewModelDelegate <NSObject>
- (void) didFailWithError: (NSError *) error;
- (void) didRecieveVehiclesList: (NSArray *) vehicles;
@end

@interface VehicleMapViewModel : NSObject
@property (weak, nonatomic) id <VehicleMapViewModelDelegate> delegate;
@property (strong, nonatomic) VehiclesAPI *api;

- (void) fetchVehiclesForPoint1: (CLLocationCoordinate2D) topLeft andPoint2: (CLLocationCoordinate2D) bottomRight ;
@end

NS_ASSUME_NONNULL_END

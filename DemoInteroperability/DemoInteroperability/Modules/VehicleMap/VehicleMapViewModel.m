//
//  VehicleMapViewModel.m
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

#import "VehicleMapViewModel.h"

@implementation VehicleMapViewModel

- (void) fetchVehiclesForPoint1: (CLLocationCoordinate2D) topLeft andPoint2: (CLLocationCoordinate2D) bottomRight{
    self.api = [[VehiclesAPI alloc] initWithP1Lat:topLeft.latitude p1Long:topLeft.longitude p2Lat:bottomRight.latitude p2Long:bottomRight.longitude];
    
    [self.api fetchVehiclesForMapWithCompletion:^(NSArray * vehicles, NSError *error) {
        if (vehicles != nil){
            if (self.delegate && [self.delegate respondsToSelector:@selector(didRecieveVehiclesList:)]){
                [self.delegate didRecieveVehiclesList:vehicles];
            }
        }
        else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(didFailWithError:)]){
                [self.delegate didFailWithError:error];
            }
        }
    }];
}

@end

//
//  VehicleMapViewModelTest.m
//  DemoInteroperabilityTests
//
//  Created by Gaurav Tiwari on 03/08/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VehicleMapViewModel.h"
#import "DemoInteroperability-Swift.h"

@interface VehicleMapViewModelTest : XCTestCase{
    VehicleMapViewModel *vehicleMapViewModel;
    VehiclesAPI *vehicleAPI;
}

@end

@implementation VehicleMapViewModelTest

- (void)setUp {
    [super setUp];
    vehicleMapViewModel = [[VehicleMapViewModel alloc] init];
    vehicleAPI = [[VehiclesAPI alloc] initWithP1Lat:53.694865 p1Long:9.757589 p2Lat:53.394655 p2Long:10.099891];
}

- (void)tearDown {
    vehicleMapViewModel = nil;
    vehicleAPI = nil;
    [super tearDown];
}

- (void)testFetchWithNoService {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription: @"No VehicleAPI"];
    
    // giving no service to a view model
    vehicleMapViewModel.api = nil;
    
    // expected to not be able to fetch vehicles
    [expectation fulfill];
    
    [self waitForExpectations:[NSArray arrayWithObject:expectation] timeout:5.0];
}

- (void)testFetchVehicles {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription: @"Vehicles fetch"];
    
    CLLocationCoordinate2D point1 = CLLocationCoordinate2DMake(53.69379953502656, 10.144576873944374);
    CLLocationCoordinate2D point2 = CLLocationCoordinate2DMake(53.407917657957455, 9.84282312605572);
    
    // giving a service for fetching vehicles
    [vehicleMapViewModel fetchVehiclesForPoint1:point1 andPoint2:point2];
    
    [expectation fulfill];
    [self waitForExpectations:[NSArray arrayWithObject:expectation] timeout:5.0];
}

@end

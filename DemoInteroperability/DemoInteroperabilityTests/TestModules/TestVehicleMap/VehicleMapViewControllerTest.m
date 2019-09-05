//
//  VehicleMapViewControllerTests.m
//  DemoInteroperabilityTests
//
//  Created by Gaurav Tiwari on 03/08/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VehicleMapViewController.h"

static NSString *vehicleMapViewController = @"VehicleMapViewController";
static NSString *main = @"Main";

@interface VehicleMapViewControllerTests : XCTestCase

@end

@implementation VehicleMapViewControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void) testVehicleMapViewModel{
    NSBundle *storyboardBundle = [NSBundle mainBundle];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:main bundle:storyboardBundle];
    VehicleMapViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:vehicleMapViewController];
    [viewController viewDidLoad];
    XCTAssertNotNil(viewController.vehicleMapViewModel);
}

- (void) testVehicleMapView{
    NSBundle *storyboardBundle = [NSBundle mainBundle];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:main bundle:storyboardBundle];
    VehicleMapViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:vehicleMapViewController];
    [viewController loadView];
    XCTAssertNotNil(viewController.mapView);
}

@end

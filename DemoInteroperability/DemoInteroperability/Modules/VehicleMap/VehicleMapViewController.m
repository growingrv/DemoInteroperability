//
//  VehicleMapViewController.m
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

#import "VehicleMapViewController.h"
#import "MapAnnotation.h"
#import "UIImage+Category.h"

@interface VehicleMapViewController  () <VehicleMapViewModelDelegate, MKMapViewDelegate> {

}
@end

@implementation VehicleMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vehicleMapViewModel = [[VehicleMapViewModel alloc] init];
    self.vehicleMapViewModel.delegate = self;
    [self.mapView setRegion:[self.mapView regionThatFits:[[Utilities shared] getHamburgRegion]]]; // Showing Hamburg Region
    [self fetchVehiclesInMapBounds];
}

#pragma mark - Local Methods

- (void) fetchVehiclesInMapBounds {
    CLLocationCoordinate2D topLeft = [self topLeftFromRect:self.mapView.visibleMapRect];
    CLLocationCoordinate2D bottomRight = [self bottomRightFromRect:self.mapView.visibleMapRect];

    dispatch_async(dispatch_get_main_queue(), ^{
        [[ActivityIndicator shared] showAcitivityIndicatorWithView:self.view message:@""];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.vehicleMapViewModel fetchVehiclesForPoint1:topLeft andPoint2:bottomRight];
    });
}

- (CLLocationCoordinate2D) topLeftFromRect : (MKMapRect) rect{
    CLLocationCoordinate2D topLeft = MKCoordinateForMapPoint(MKMapPointMake(MKMapRectGetMaxX(rect),rect.origin.y));
    return topLeft;
}

- (CLLocationCoordinate2D) bottomRightFromRect : (MKMapRect) rect{
    CLLocationCoordinate2D bottomRight = MKCoordinateForMapPoint(MKMapPointMake(rect.origin.x,MKMapRectGetMaxY(rect)));
    return bottomRight;
}

- (void) displayVehiclesInMap: (NSArray *) vehicleArray{
    if (vehicleArray.count > 0){
        [self drawAllVehiclesOnMap:vehicleArray];
    }
}

- (void) drawAllVehiclesOnMap: (NSArray *) vehicleArray {
    for (MapAnnotation *annotation in self.mapView.annotations){
        [self.mapView removeAnnotation:annotation];
    }
    
    for (Vehicle *vehicle in vehicleArray){
        CLLocationCoordinate2D vehicleCoordinate2D = CLLocationCoordinate2DMake(vehicle.vehicleCoordinates.latitude, vehicle.vehicleCoordinates.longitude) ;
        MapAnnotation *vehicleObject = [[MapAnnotation alloc] initWithName:@"" address:@"" coordinate:vehicleCoordinate2D vehicle:vehicle];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView addAnnotation:vehicleObject];
        });
    }
}

#pragma Mark VehicleMapViewModelDelegate Methods
- (void) didFailWithError: (NSError *) error{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ActivityIndicator shared] hideActivityIndicatorWithView:self.view];
        [self presentViewController:[[Utilities shared] showAlertWithTitle:@"Error" message:error.localizedDescription] animated:true completion:nil];
    });
}

- (void) didRecieveVehiclesList: (NSArray *) vehicles{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ActivityIndicator shared] hideActivityIndicatorWithView:self.view];
        NSString *title = [NSString stringWithFormat:@"%lu vehicles around", (unsigned long)vehicles.count];
        [self presentViewController:[[Utilities shared] showAlertWithTitle:title message:title] animated:true completion:nil];
        [self displayVehiclesInMap:vehicles];
    });
}

#pragma mark - MKMapViewDelegate Methods
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    NSString *identifier = @"MapAnnotation";
    if ([annotation isKindOfClass: [MapAnnotation class]]){
        MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        else {
            [annotationView setAnnotation:annotation];
        }
        annotationView.enabled = true;
        
        MapAnnotation *mapAnnotation = (MapAnnotation *) annotation;
        UIImage *tempImage;
        if ([mapAnnotation.vehicle.vehicleFleetType isEqualToString:@"TAXI"]){
            tempImage = [UIImage imageNamed: @"Taxi"];
        }
        if ([mapAnnotation.vehicle.vehicleFleetType isEqualToString:@"POOLING"]){
            tempImage = [UIImage imageNamed: @"Pooling"];
        }
        annotationView.image = [UIImage imageRotatedByDegrees:tempImage degrees:mapAnnotation.vehicle.vehicleHeading];

        return annotationView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [self fetchVehiclesInMapBounds];
}

@end

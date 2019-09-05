//
//  MapAnnotation.h
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 31/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "DemoInteroperability-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapAnnotation : NSObject <MKAnnotation>{
    NSString *_name;
    NSString *_address;
    CLLocationCoordinate2D _coordinate;
    Vehicle *_vehicle;
}

@property (copy) NSString *name;
@property (copy) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (copy) Vehicle *vehicle;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate vehicle:(Vehicle*)vehicle;
@end

NS_ASSUME_NONNULL_END

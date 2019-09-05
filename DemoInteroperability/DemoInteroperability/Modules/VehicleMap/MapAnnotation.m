//
//  MapAnnotation.m
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 31/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;
@synthesize vehicle = _vehicle;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate vehicle:(Vehicle*)vehicle{
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
        _vehicle = vehicle;
    }
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknown";
    else
        return _name;
}

- (NSString *)subtitle {
    return _address;
}


@end

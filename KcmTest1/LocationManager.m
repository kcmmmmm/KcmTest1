//
//  LocationManager.m
//  KcmTest1
//
//  Created by openobject on 2017. 3. 24..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "LocationManager.h"

static LocationManager *locationManager;

@implementation LocationManager

+ (instancetype)manager {
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        locationManager = [[LocationManager alloc] init];
    });
    
    return locationManager;
}

- (CLLocationCoordinate2D)getLocation {
    CLLocationManager * locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [locationManager startUpdatingLocation];
    
    CLLocation* location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
//    coordinate.latitude;          //위도
//    coordinate.longitude;         //경도
    
    return coordinate;
}

@end

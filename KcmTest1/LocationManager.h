//
//  LocationManager.h
//  KcmTest1
//
//  Created by openobject on 2017. 3. 24..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>

+ (instancetype)manager;
- (CLLocationCoordinate2D)getLocation;


@end

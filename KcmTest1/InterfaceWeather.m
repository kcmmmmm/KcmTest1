//
//  InterfaceWeather.m
//  KcmTest1
//
//  Created by openobject on 2017. 3. 23..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "InterfaceWeather.h"
#import "LocationManager.h"

@implementation StationInfo
@end

@implementation GridInfo
@end

@implementation TemperatureInfo
@end

@implementation PrecipitationInfo
@end

@implementation WindInfo
@end

@implementation SkyInfo
@end

@implementation MinutelyInfo
@end

@implementation DayInfo
@end

@implementation SummaryInfo
@end

@implementation StationWeatherInfo
@end

@implementation MinutelyWeatherInfo
@end

@implementation SummaryWeatherInfo
@end

@implementation ResStation
@end

@implementation ResMinutelyWeather
@end

@implementation ResSummaryWeather
@end

@implementation InterfaceWeather

+ (instancetype)instance {
    __block InterfaceWeather *instance;
  
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
       instance = [[InterfaceWeather alloc] init];
    });
    
    return instance;
}

- (void)doStationInfo:(Class)responseCls success:(void (^)(ResStation* res))success
              failure:(void (^)(NSError *error))failure
{
    LocationManager *lm = [LocationManager manager];
    NSString *lat = [NSString stringWithFormat:@"%f", [lm getLocation].latitude];
    NSString *lon = [NSString stringWithFormat:@"%f", [lm getLocation].longitude];
    
    NSDictionary* param = @{
                            @"version":@"1",
                            @"lat":lat,
                            @"lon":lon,
                            };
    
    NSLog(@"doStationInfo send:%@",param);
    
    [[ServerInterfaceManager manager] sendRequestForUrl:@"http://apis.skplanetx.com/weather/code/station" param:param responseCls:responseCls success:^(id data) {
        if (success) {
            success(data);
            NSLog(@"data => %@", data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"error => %@", error.description);
        }
    }];
}

- (void)doMinutelyWeather:(Class)responseCls success:(void (^)(ResMinutelyWeather* res))success
          failure:(void (^)(NSError *error))failure
{
    
    LocationManager *lm = [LocationManager manager];
    CLLocationCoordinate2D coordinate = [lm getLocation];
    
    NSString *lat = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    NSDictionary* param = @{
                             @"version":@"1",
                             @"lat":lat,
                             @"lon":lon,
                             };
    
    NSLog(@"doMinutelyWeather send:%@",param);
    
    [[ServerInterfaceManager manager] sendRequestForUrl:@"http://apis.skplanetx.com/weather/current/minutely" param:param responseCls:responseCls success:^(id data) {
        if (success) {
            success(data);
            NSLog(@"data => %@", data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"error => %@", error.description);
        }
    }];
}

- (void)doSummaryWeather:(Class)responseCls
                     lat:(NSString *)lat
                     lon:(NSString *)lon
                   stnId:(NSString *)stnId
                 success:(void (^)(ResSummaryWeather* res))success
                 failure:(void (^)(NSError *error))failure
{
    NSDictionary* param = @{
                            @"version":@"1",
                            @"lat":lat,
                            @"lon":lon,
                            @"stnid":stnId,
                            };
    
    NSLog(@"doSummaryWeather send:%@",param);
    
    [[ServerInterfaceManager manager] sendRequestForUrl:@"http://apis.skplanetx.com/weather/summary" param:param responseCls:responseCls success:^(id data) {
        if (success) {
            success(data);
            NSLog(@"data => %@", data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"error => %@", error.description);
        }
    }];
}

@end

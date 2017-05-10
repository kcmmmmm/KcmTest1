//
//  InterfaceWeather.h
//  KcmTest1
//
//  Created by openobject on 2017. 3. 23..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerInterfaceManager.h"
#import "ServerResponse.h"

@protocol MinutelyInfo;
@protocol StationInfo;
@protocol SummaryInfo;

@interface StationInfo : JSONModel //관측소정보

@property (nonatomic) NSString<Optional> *id;           //관측소 지점번호
@property (nonatomic) NSString<Optional> *latitude;     //관측소 위도
@property (nonatomic) NSString<Optional> *longitude;    //관측소 경도
@property (nonatomic) NSString<Optional> *name;         //관측소명
@property (nonatomic) NSString<Optional> *type;         //관측소 유형 - KMA: 기상청 관측소 - BTN: SKP 관측소

@end

@interface GridInfo : JSONModel  //격자정보

@property (nonatomic) NSString<Optional> *latitude;     //격자중심 위도
@property (nonatomic) NSString<Optional> *longitude;    //격자중심 경도
@property (nonatomic) NSString<Optional> *city;         //시(특별, 광역), 도
@property (nonatomic) NSString<Optional> *county;       //시, 군, 구
@property (nonatomic) NSString<Optional> *village;      //읍, 면, 동

@end

@interface TemperatureInfo : JSONModel  //기온정보

@property (nonatomic) NSString<Optional> *tc;   //현재기온
@property (nonatomic) NSString<Optional> *tmax; //오늘의 최고기온
@property (nonatomic) NSString<Optional> *tmin; //오늘의 최저기온

@end

@interface PrecipitationInfo : JSONModel //강수정보

@property (nonatomic) NSString<Optional> *rain; //일 누적 강우랑(mm)
@property (nonatomic) NSString<Optional> *snow; //일 누적 적설랑(cm)

@end

@interface WindInfo : JSONModel //바람정보

@property (nonatomic) NSString<Optional> *wdir; //풍향
@property (nonatomic) NSString<Optional> *wspd; //풍속

@end

@interface SkyInfo : JSONModel  //하늘상태정보

@property (nonatomic) NSString<Optional> *name; //하늘상태코드명
@property (nonatomic) NSString<Optional> *code; //하늘상태코드

@end

@interface MinutelyInfo : JSONModel

@property (nonatomic) SkyInfo<Optional> *sky;
@property (nonatomic) StationInfo<Optional> *station;
@property (nonatomic) WindInfo<Optional> *wind;
@property (nonatomic) TemperatureInfo<Optional> *temperature;

@end

@interface DayInfo : JSONModel

@property (nonatomic) SkyInfo<Optional> *sky;
@property (nonatomic) PrecipitationInfo<Optional> *precipitation;
@property (nonatomic) WindInfo<Optional> *wind;
@property (nonatomic) TemperatureInfo<Optional> *temperature;

@end

@interface SummaryInfo : JSONModel

@property (nonatomic) GridInfo<Optional> *grid;
@property (nonatomic) DayInfo<Optional> *yesterday;
@property (nonatomic) DayInfo<Optional> *today;
@property (nonatomic) DayInfo<Optional> *tomorrow;
@property (nonatomic) DayInfo<Optional> *dayAfterTomorrow;
@property (nonatomic) NSString<Optional> *timeRelease;

@end

@interface StationWeatherInfo : JSONModel

@property (nonatomic) NSArray<StationInfo, Optional> *station;

@end

@interface MinutelyWeatherInfo : JSONModel

@property (nonatomic) NSArray<MinutelyInfo, Optional> *minutely;

@end

@interface SummaryWeatherInfo : JSONModel

@property (nonatomic) NSArray<SummaryInfo, Optional> *summary;

@end


@interface ResStation : ServerResponse

@property (nonatomic) StationWeatherInfo<Optional> *weather;

@end

@interface ResMinutelyWeather : ServerResponse

@property (nonatomic) MinutelyWeatherInfo<Optional> *weather;

@end

@interface ResSummaryWeather : ServerResponse

@property (nonatomic) SummaryWeatherInfo<Optional> *weather;

@end


@interface InterfaceWeather : NSObject

+ (instancetype)instance;

- (void)doStationInfo:(Class)responseCls success:(void (^)(ResStation* res))success
              failure:(void (^)(NSError *error))failure;

- (void)doMinutelyWeather:(Class)responseCls success:(void (^)(ResMinutelyWeather* res))success
          failure:(void (^)(NSError *error))failure;

- (void)doSummaryWeather:(Class)responseCls
                     lat:(NSString *)lat
                     lon:(NSString *)lon
                   stnId:(NSString *)stnId
                 success:(void (^)(ResSummaryWeather* res))success
                 failure:(void (^)(NSError *error))failure;

@end

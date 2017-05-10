//
//  ServerResponse.h
//  KcmTest1
//
//  Created by openobject on 2017. 3. 23..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface CommonInfo : JSONModel

@property (nonatomic) NSString<Optional> *alertYn;
@property (nonatomic) NSString<Optional> *stormYn;

@end

@interface ResultInfo : JSONModel

@property (nonatomic) NSString<Optional> *code;
@property (nonatomic) NSString<Optional> *message;
@property (nonatomic) NSString<Optional> *requestUrl;

@end

@interface ServerResponse : JSONModel

@property (nonatomic) NSDictionary<Optional> *originalResponse;
@property (nonatomic) CommonInfo<Optional> *common;
@property (nonatomic) ResultInfo<Optional> *result;

@end

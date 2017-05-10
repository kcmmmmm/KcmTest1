//
//  ServerResponse.m
//  KcmTest1
//
//  Created by openobject on 2017. 3. 23..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "ServerResponse.h"

@implementation CommonInfo
@end

@implementation ResultInfo
@end

@implementation ServerResponse

- (id)initWithDictionary:(NSDictionary*)dict error:(NSError**)err {
    self = [super initWithDictionary:dict error:err];
    if ( self ) {
        _originalResponse = dict;
    }
    
    return self;
}

@end

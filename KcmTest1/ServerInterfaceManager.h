//
//  ServerInterfaceManager.h
//  KcmTest1
//
//  Created by openobject on 2017. 3. 23..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerInterfaceManager : NSObject {
    NSMutableDictionary* _interfaceMap;
}

+ (instancetype)manager;

- (void)sendRequestForUrl:(NSString *)url
                    param:(NSDictionary *)param
              responseCls:(Class)responseCls
                  success:(void (^)(id data)) success
                  failure:(void (^)(NSError *error)) failure;

@end

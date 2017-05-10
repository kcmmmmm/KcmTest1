//
//  ServerInterfaceManager.m
//  KcmTest1
//
//  Created by openobject on 2017. 3. 23..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "ServerInterfaceManager.h"
#import <AFNetworking/AFNetworking.h>
#import "ServerResponse.h"

static ServerInterfaceManager *s_manager;
static AFHTTPSessionManager* s_httpManager;

@implementation ServerInterfaceManager

+ (instancetype)manager {
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        s_manager = [[ServerInterfaceManager alloc] init];
    });
    return s_manager;
}

- (void)httpManager {
    s_httpManager = [AFHTTPSessionManager manager];
    s_httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    s_httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [s_httpManager.requestSerializer setValue:@"2fe35ec8-e1f8-39ca-97ec-06148361f3b4" forHTTPHeaderField:@"appKey"];
}

- (void)_sendRequestForUrl:(NSString *)url
                    param:(NSDictionary *)param
               responseCls:(Class)responseCls
                  success:(void (^)(id data)) success
                  failure:(void (^)(NSError *error)) failure {
    
    [s_httpManager GET:url
            parameters:param
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   ServerResponse *res = [[responseCls alloc] initWithDictionary:responseObject error:nil];
                   success(res);
    
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSString *errMsg = @"";
                   @try {
                       NSData *data = [[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
                       errMsg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                   } @catch (NSException *exception) {
                   }
                   
                   NSLog(@"failure %@", errMsg);
                   
                   dispatch_async(dispatch_get_main_queue(), ^{
                       failure(error);
                   });
    
               }];

}

- (void)sendRequestForUrl:(NSString *)url
                    param:(NSDictionary *)param
              responseCls:(Class)responseCls
                  success:(void (^)(id data)) success
                  failure:(void (^)(NSError *error)) failure {
    
    [self httpManager];
    
    [self _sendRequestForUrl:url
                       param:param
                 responseCls:(Class)responseCls
                     success:^(id data) {
                         if (success) {
                             success(data);
                         }
                     } failure:^(NSError *error) {
                         if (failure) {
                             failure(error);
                         }
                     }];
    
}


@end

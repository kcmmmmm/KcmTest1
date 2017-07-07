//
//  TouchIDViewController.m
//  KcmTest1
//
//  Created by wimz-kcm on 2017. 7. 7..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "TouchIDViewController.h"

@interface TouchIDViewController ()

@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"지문인증" reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                NSLog(@"지문인증 성공");
            }
            else {
                NSLog(@"지문인증 실패");
                [self didUserAuthenticationFailed:error];
            }
        }];
    }
    else {
        NSLog(@"터치아이디 사용 불가");
        [self didUserAuthenticationFailed:error];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didUserAuthenticationFailed:(NSError *)error {
   
    switch (error.code) {
        case LAErrorAuthenticationFailed:
        {
            NSLog(@"failed");
        }
            break;
        case LAErrorUserCancel:
        {
            NSLog(@"cancel by user");
        }
            break;
        case LAErrorUserFallback:
        {
            NSLog(@"user want to enter password");
        }
            break;
        case LAErrorSystemCancel:
        {
            NSLog(@"cancel by system");
        }
            break;
        default:
        {
            NSLog(@"failed");
        }
            break;
    }
}

@end

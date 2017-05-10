//
//  TodayViewController.m
//  KcmTest1TodayWidget
//
//  Created by openobject on 2017. 3. 21..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"widget height => %f", self.view.bounds.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}


#pragma mark - IBAction

- (IBAction)touchUpInsideWidgetBtn:(id)sender {
    NSURL* url = [NSURL URLWithString:@"kcmtest://"];
    
    switch ([sender tag]) {
        case 0:
            url = [NSURL URLWithString:@"kcmtest://test"];
            break;
        case 1:
            url = [NSURL URLWithString:@"kcmtest://"];
            break;
        default:
            break;
    }
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        NSLog(@"open url %d", success);
    }];
}

@end

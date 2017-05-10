//
//  CustomNavigationBar.m
//  KcmTest1
//
//  Created by openobject on 2017. 4. 17..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar

+ (void)navigationBarTitleViewController:(UIViewController *)controller withTitle:(NSString *)title {
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    lbTitle.text = title;
    lbTitle.textColor = RGB(0, 0, 0);
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.font = [UIFont systemFontOfSize:16.0f];
    lbTitle.contentMode = UIViewContentModeCenter;
    
    controller.navigationController.navigationBar.translucent = NO;
    controller.navigationController.navigationBar.barTintColor = RGB(254, 205, 81);
    [controller.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    controller.navigationController.navigationBar.shadowImage = [UIImage new];
    [controller.navigationItem setTitleView:lbTitle];
}

+ (UIBarButtonItem *)drawBackButton:(UIViewController *)controller withAction:(SEL)action {
    
    //이전 버튼
    UIBarButtonItem *barButtonItem = [CustomNavigationBar createBarButtonItemForViewController:controller withImageName:@"btn_main_back" withAction:action];
    
    [controller.navigationItem setHidesBackButton:YES];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
        [negativeSpacer setWidth:-16];
    
    [controller.navigationItem setLeftBarButtonItems:@[negativeSpacer, barButtonItem] animated:NO];
    
    [barButtonItem setAccessibilityLabel:@"이전"];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)createBarButtonItemForViewController:(UIViewController *)controller
                                            withImageName:(NSString *)imageName
                                               withAction:(SEL)action {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    
//    NSString *nomalImageName = [NSString stringWithFormat:@"%@_no", imageName];
//    NSString *highlightedImageName = [NSString stringWithFormat:@"%@_ov", imageName];
//    
//    [button setBackgroundImage:[UIImage imageNamed:nomalImageName]
//                      forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:highlightedImageName]
//                      forState:UIControlStateHighlighted];

    [button setTitle:@"이전" forState:UIControlStateNormal];
    [button setTitleColor:RGB(0, 0, 0) forState:UIControlStateNormal];
    
    [button addTarget:controller
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

@end

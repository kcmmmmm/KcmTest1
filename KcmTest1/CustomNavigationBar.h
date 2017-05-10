//
//  CustomNavigationBar.h
//  KcmTest1
//
//  Created by openobject on 2017. 4. 17..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomNavigationBar : NSObject

+ (void)navigationBarTitleViewController:(UIViewController *)controller withTitle:(NSString *)title;
+ (UIBarButtonItem *)drawBackButton:(UIViewController *)controller withAction:(SEL)action;

@end

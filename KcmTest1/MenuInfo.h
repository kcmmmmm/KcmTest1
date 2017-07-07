//
//  MenuInfo.h
//  KcmTest1
//
//  Created by openobject on 2017. 2. 27..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MenuID) {
    MenuPagingView,
    DynamicView,
    PageView,
    DynamicMenuView,
    ZoomScrollView,
    AddressBookView,
    ScannerView,
    TouchIDView,
    ParallaxScrollView,
};

@interface MenuInfo : NSObject {
    MenuID _menuID;
    NSString* _menuTitle;
    Class _menuClass;
}

- (instancetype)initWithMenuID:(MenuID)menuID menuClass:(Class)menuClass menuTitle:(NSString *)menuTitle;

@property (readonly, nonatomic) MenuID menuID;
@property (readonly, nonatomic) Class menuClass;
@property (readonly, nonatomic) NSString *menuTitle;

@end

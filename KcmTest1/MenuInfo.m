//
//  MenuInfo.m
//  KcmTest1
//
//  Created by openobject on 2017. 2. 27..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "MenuInfo.h"

@implementation MenuInfo

- (instancetype)initWithMenuID:(MenuID)menuID menuClass:(Class)menuClass menuTitle:(NSString *)menuTitle
{
    self = [super init];
    if (self) {
        self->_menuID = menuID;
        self->_menuClass = menuClass;
        self->_menuTitle = menuTitle;
    }
    
    return self;
}

- (MenuID)menuID {
    return _menuID;
}

- (Class)menuClass {
    return _menuClass;
}

- (NSString *)menuTitle {
    return _menuTitle;
}

@end

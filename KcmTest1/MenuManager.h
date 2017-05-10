//
//  MenuManager.h
//  KcmTest1
//
//  Created by openobject on 2017. 2. 28..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuInfo.h"

extern NSArray* makeIndexListFromMenus(NSArray* menus);

@interface MenuManager : NSObject {
    NSMutableArray *_menu;
    NSMutableArray *_mainMenu;
}

+ (instancetype)manager;
- (MenuInfo *)menuWithID:(MenuID)menuID;

-(NSArray *)mainMenu;

@end

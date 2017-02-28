//
//  MenuManager.m
//  KcmTest1
//
//  Created by openobject on 2017. 2. 28..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "MenuManager.h"
#import "PagingViewController.h"

static MenuManager *menuManager;

@implementation MenuManager

+ (instancetype)manager {
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        menuManager = [[MenuManager alloc] init];
    });
    
    return menuManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _menu = [[NSMutableArray alloc] init];
        
        [self loadMenuList];
    }
    
    return self;
}

- (MenuInfo *)menuWithID:(MenuID)menuID {
    for (MenuInfo *mi in _menu) {
        if (mi.menuID == menuID) {
            return mi;
        }
    }
    return nil;
}

- (void)loadMenuList {
    
    [self addMenuInfo:[[MenuInfo alloc] initWithMenuID:MenuPagingView
                                             menuClass:[PagingViewController class]
                                             menuTitle:@"페이징뷰"]
     ];
    
}

- (void)addMenuInfo:(MenuInfo *)menuInfo {
    if ([_menu indexOfObject:menuInfo] == NSNotFound) {
        [_menu addObject:menuInfo];
    } else {
        NSLog(@"%@ error!", NSStringFromSelector(_cmd));
    }
}

- (NSArray *)mainMenu {
    if (!_mainMenu) {
        _mainMenu = [NSMutableArray array];
        
        [_mainMenu addObject:[self menuWithID:MenuPagingView]];
    }
    return _mainMenu;
}

@end

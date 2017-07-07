//
//  MenuManager.m
//  KcmTest1
//
//  Created by openobject on 2017. 2. 28..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "MenuManager.h"
#import "PagingViewController.h"
#import "DynamicViewController.h"
#import "PageViewController.h"
#import "DynamicMenuViewController.h"
#import "ZoomScrollViewController.h"
#import "AddressBookViewController.h"
#import "ScannerViewController.h"
#import "TouchIDViewController.h"
#import "ParallaxScrollViewController.h"

NSArray* makeIndexListFromMenus(NSArray* menus) {
    NSMutableArray* idxArr = [NSMutableArray array];
    for (MenuInfo* mi in menus) {
        [idxArr addObject:[NSNumber numberWithInteger:mi.menuID]];
    }
    return idxArr;
}

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
    
    [self addMenuInfo:[[MenuInfo alloc] initWithMenuID:DynamicView
                                             menuClass:[DynamicViewController class]
                                             menuTitle:@"다이나믹뷰"]
     ];
    
    [self addMenuInfo:[[MenuInfo alloc] initWithMenuID:PageView
                                             menuClass:[PageViewController class]
                                             menuTitle:@"페이지뷰"]
     ];
    
    [self addMenuInfo:[[MenuInfo alloc] initWithMenuID:DynamicMenuView
                                             menuClass:[DynamicMenuViewController class]
                                             menuTitle:@"다이나믹메뉴뷰"]
     ];
    
    [self addMenuInfo:[[MenuInfo alloc] initWithMenuID:ZoomScrollView
                                             menuClass:[ZoomScrollViewController class]
                                             menuTitle:@"줌스크롤뷰"]
     ];

    [self addMenuInfo:[[MenuInfo alloc] initWithMenuID:AddressBookView
                                             menuClass:[AddressBookViewController class]
                                             menuTitle:@"주소록"]
     ];
    
    [self addMenuInfo:[[MenuInfo alloc] initWithMenuID:ScannerView
                                             menuClass:[ScannerViewController class]
                                             menuTitle:@"스캐너"]
     ];
    
    [self addMenuInfo:[[MenuInfo alloc] initWithMenuID:TouchIDView
                                             menuClass:[TouchIDViewController class]
                                             menuTitle:@"지문인증"]
     ];
    
    [self addMenuInfo:[[MenuInfo alloc] initWithMenuID:ParallaxScrollView
                                             menuClass:[ParallaxScrollViewController class]
                                             menuTitle:@"스크롤"]
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
        [_mainMenu addObject:[self menuWithID:DynamicView]];
        [_mainMenu addObject:[self menuWithID:DynamicMenuView]];
        [_mainMenu addObject:[self menuWithID:PageView]];
        [_mainMenu addObject:[self menuWithID:ZoomScrollView]];
        [_mainMenu addObject:[self menuWithID:AddressBookView]];
        [_mainMenu addObject:[self menuWithID:ScannerView]];
        [_mainMenu addObject:[self menuWithID:TouchIDView]];
        [_mainMenu addObject:[self menuWithID:ParallaxScrollView]];
    }
    return _mainMenu;
}

@end

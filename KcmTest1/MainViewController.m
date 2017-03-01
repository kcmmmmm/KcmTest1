//
//  MainViewController.m
//  KcmTest1
//
//  Created by openobject on 2017. 2. 27..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "MainViewController.h"
#import "MenuManager.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"test git commit");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openMenuWithID:(MenuID)menuID {
    
    MenuInfo *menuInfo = [[MenuManager manager] menuWithID:menuID];
    if (menuInfo) {
        Class cls = menuInfo.menuClass;
        if (cls && [cls isSubclassOfClass:[UIViewController class]]) {
            UIViewController *vc = [[cls alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            NSLog(@"%@ cls error!", NSStringFromSelector(_cmd));
        }
    }
    else {
        NSLog(@"%@ error!", NSStringFromSelector(_cmd));
    }
    
}

- (IBAction)touchUpInsidePaging:(id)sender {
    [self openMenuWithID:MenuPagingView];
}

@end

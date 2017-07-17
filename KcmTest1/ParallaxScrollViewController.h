//
//  ParallaxScrollViewController.h
//  KcmTest1
//
//  Created by wimz-kcm on 2017. 7. 7..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParallaxScrollViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    UIImageView *_imgView;
    UIView *_headerView;
    UIScrollView *_headerScrollView;
    CGFloat _beginOffsetY;
}

@end

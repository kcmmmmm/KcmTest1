//
//  ZoomScrollViewController.h
//  KcmTest1
//
//  Created by openobject on 2017. 4. 10..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomScrollViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    UIImageView *_imgView;
}

@end

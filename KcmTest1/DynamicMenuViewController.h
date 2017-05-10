//
//  DynamicMenuViewController.h
//  KcmTest1
//
//  Created by openobject on 2017. 4. 7..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UIDynamicAnimator *_animator;
    UIGravityBehavior *_gravity;
    UICollisionBehavior *_collision;
    
    UIView *_upperMenu;
    UIButton *_toggleMenu;
}

@end

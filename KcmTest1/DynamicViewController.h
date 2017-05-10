//
//  DynamicViewController.h
//  KcmTest1
//
//  Created by openobject on 2017. 4. 6..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicViewController : UIViewController <UICollisionBehaviorDelegate> {
    UIDynamicAnimator *_animator;
    UIGravityBehavior *_gravity;
    UICollisionBehavior *_collision;
    BOOL _firstContact;
}

@end

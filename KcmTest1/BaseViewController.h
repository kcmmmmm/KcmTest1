//
//  BaseViewController.h
//  KcmTest1
//
//  Created by openobject on 2017. 4. 6..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresentAnimation.h"
#import "DismissAnimation.h"
#import "PushAnimation.h"

@interface BaseViewController : UIViewController <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>
{
    PresentAnimation *_preseneAnimation;
    DismissAnimation *_dismissAnimation;
    PushAnimation *_pushAnimation;
}

@end

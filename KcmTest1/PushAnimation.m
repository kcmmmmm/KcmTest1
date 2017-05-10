//
//  PushAnimation.m
//  KcmTest1
//
//  Created by openobject on 2017. 4. 7..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "PushAnimation.h"

@implementation PushAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.7;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromVC.view.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         fromVC.view.alpha = 1.0;
                         toVC.view.alpha = 1.0;
                         [transitionContext completeTransition:YES];
                     }];
}


@end

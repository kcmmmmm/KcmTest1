//
//  PresentAnimation.m
//  KcmTest1
//
//  Created by openobject on 2017. 4. 6..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "PresentAnimation.h"

@implementation PresentAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //1. obtain state from the context
    UIViewController *toViewController = nil;
    toViewController = [transitionContext
                        viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    UIViewController *fromViewController = nil;
    fromViewController = [transitionContext
                          viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //2. obtain the container view
    UIView *containerView = [transitionContext containerView];
    
    //3. set initial state
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    toViewController.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
    
    //4. add the view
    [containerView addSubview:toViewController.view];
    
    //5. animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromViewController.view.alpha = 0.2;
                         toViewController.view.frame = finalFrame;
                     }
                     completion:^(BOOL finished) {
                         //6. Set completed! (Important!)
                         [transitionContext completeTransition:YES];
                         fromViewController.view.alpha = 1.0;
                     }];
}

@end

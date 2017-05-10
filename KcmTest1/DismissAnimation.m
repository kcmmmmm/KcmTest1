//
//  DismissAnimation.m
//  KcmTest1
//
//  Created by openobject on 2017. 4. 6..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "DismissAnimation.h"

@implementation DismissAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //1.
    UIViewController *toViewController = nil;
    toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = nil;
    fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    UIView *containerView = [transitionContext containerView];
    
    toViewController.view.frame = finalFrame;
    toViewController.view.alpha = 0.5;
    
    //2
    [containerView addSubview:toViewController.view];
    [containerView sendSubviewToBack:toViewController.view];
    
    //3. Actual animation
    CGRect fromViewFrame = fromViewController.view.frame;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect shrunkenFrame = CGRectInset(fromViewFrame, fromViewFrame.size.width/4, fromViewFrame.size.height/4);
    CGRect fromFinalFrame = CGRectOffset(shrunkenFrame, 0, screenBounds.size.height);
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    //4. animate
    [UIView
     animateKeyframesWithDuration:duration
     delay:0.0
     options:UIViewKeyframeAnimationOptionCalculationModeCubic
     animations:^
     {
         
         [UIView addKeyframeWithRelativeStartTime:0.0
                                 relativeDuration:0.5
                                       animations:^{
                                           fromViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
                                           toViewController.view.alpha = 0.5;
                                       }];
         
         [UIView addKeyframeWithRelativeStartTime:0.5
                                 relativeDuration:0.5
                                       animations:^{
                                           fromViewController.view.frame = fromFinalFrame;
                                           toViewController.view.alpha = 1.0;
                                       }];
     }
     completion:^(BOOL finished)
     {
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
     }];
}

@end

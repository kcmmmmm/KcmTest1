//
//  CustomAlertView.m
//  KcmTest1
//
//  Created by openobject on 2017. 3. 15..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "CustomAlertView.h"
#import <QuartzCore/QuartzCore.h>

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

UIImage* imageWithColor(UIColor* color) {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#define MAX_ALERT_HEIGHT 360.0f

@implementation CustomAlertView

+ (void)showMessagePopup:(NSString*)message
                 handler:(void(^)(NSInteger btnIndex))onComp {
    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:AlertTitle
                                                      message:message
                                            cancelButtonTitle:@"확인"
                                             otherButtonTitle:nil
                                                      handler:onComp];
    [alert show];
}

+ (void)showMessagePopup:(NSString*)message
       cancelButtonTitle:(NSString*)cancelButtonTitle
        otherButtonTitle:(NSString*)otherButtonTitle
                 handler:(void(^)(NSInteger btnIndex))onComp {
    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:AlertTitle
                                                      message:message
                                            cancelButtonTitle:cancelButtonTitle
                                             otherButtonTitle:otherButtonTitle
                                                      handler:onComp];
    [alert show];
}

+ (void)showMessagePopup:(NSString*)message
              titleImage:(NSString*)image
       cancelButtonTitle:(NSString*)cancelButtonTitle
        otherButtonTitle:(NSString*)otherButtonTitle
       otherButtonTitle2:(NSString*)otherButtonTitle2
                 handler:(void(^)(NSInteger btnIndex))onComp {
    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:AlertTitle
                                                      message:message
                                                   titleImage:image
                                            cancelButtonTitle:cancelButtonTitle
                                             otherButtonTitle:otherButtonTitle
                                            otherButtonTitle2:otherButtonTitle2
                                                      handler:onComp];
    [alert show];
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitle:(NSString *)otherButtonTitle
            handler:(void(^)(NSInteger btnIndex))onComp
{
    btnCancel = nil;
    btnOther = nil;
    btnOther2 = nil;
    lblMessage = nil;
    
    return [self initWithTitle:title
                       message:message
                    titleImage:nil
             cancelButtonTitle:cancelButtonTitle
              otherButtonTitle:otherButtonTitle
             otherButtonTitle2:nil
                       handler:onComp];
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
         titleImage:(NSString *)image
  cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitle:(NSString *)otherButtonTitle
            handler:(void(^)(NSInteger btnIndex))onComp
{
    btnCancel = nil;
    btnOther = nil;
    btnOther2 = nil;
    lblMessage = nil;
    
    return [self initWithTitle:title
                       message:message
                    titleImage:image
             cancelButtonTitle:cancelButtonTitle
              otherButtonTitle:otherButtonTitle
             otherButtonTitle2:nil
                       handler:onComp];
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
         titleImage:(NSString *)image
  cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitle:(NSString *)otherButtonTitle
  otherButtonTitle2:(NSString *)otherButtonTitle2
            handler:(void(^)(NSInteger btnIndex))onComp
{
    CGRect frame = CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    
    self = [super initWithFrame:frame];
    if (self) {
        comp_handler = onComp;
        //        self.alpha = 0.95f;
        //        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6f];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        CGFloat alert_width = [UIScreen mainScreen].bounds.size.width - (8.0f * 2);
        CGFloat alert_top = 15.0f;
        CGFloat btn_height = 40.0f;
        
        //add text
        UIScrollView *scrollViewMsg = nil;
        
        if (title)
        {
            lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, -5, alert_width-20.0f, 49.0f)];
            lblTitle.adjustsFontSizeToFitWidth = YES;
            lblTitle.font = [UIFont systemFontOfSize:16.0f];
            lblTitle.textAlignment = NSTextAlignmentCenter;
            lblTitle.minimumScaleFactor = 12.0f / 14.0f;
            lblTitle.backgroundColor = [UIColor clearColor];
            lblTitle.textColor = RGB(51, 51, 51);
            lblTitle.text = title;
            
            lblTitle.isAccessibilityElement = YES;
            lblTitle.accessibilityTraits = UIAccessibilityTraitStaticText;
            
            alert_top += lblTitle.frame.size.height;
        }
        else
            alert_top += 49.0;
        
        if (message) {
            
            float max_msg_height = (float)(MAX_ALERT_HEIGHT - alert_top - ((cancelButtonTitle || otherButtonTitle)?(btn_height + 30.0f):30.0f));
            
            lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, alert_width-40.0f, 0.0f)];
            lblMessage.numberOfLines = 0;
            lblMessage.font = [UIFont systemFontOfSize:14.0f];
            lblMessage.textAlignment = NSTextAlignmentLeft;
            lblMessage.backgroundColor = [UIColor clearColor];
            lblMessage.textColor = RGB(51, 51, 51);
            lblMessage.text = message;
            
            [lblMessage sizeToFit];
            lblMessage.frame = CGRectMake(0.0f, 0.0f, alert_width-26.0f, lblMessage.frame.size.height);
            
            while (lblMessage.frame.size.height>max_msg_height && lblMessage.font.pointSize>12) {
                lblMessage.font = [UIFont systemFontOfSize:lblMessage.font.pointSize-1];
                [lblMessage sizeToFit];
                lblMessage.frame = CGRectMake(0.0f, 0.0f, alert_width-26.0f, lblMessage.frame.size.height);
            }
            
            scrollViewMsg = [[UIScrollView alloc] initWithFrame:CGRectMake(13.0f, alert_top, alert_width-26.0f, (lblMessage.frame.size.height>max_msg_height)?max_msg_height:lblMessage.frame.size.height)];
            scrollViewMsg.contentSize = lblMessage.frame.size;
            [scrollViewMsg addSubview:lblMessage];
            
            alert_top += scrollViewMsg.frame.size.height + 8.0;
            
            lblMessage.isAccessibilityElement = YES;
            lblMessage.accessibilityTraits = UIAccessibilityTraitStaticText;
        }
        else
            alert_top += 8.0;
        
        //add buttons
        if (cancelButtonTitle && otherButtonTitle && otherButtonTitle2)
        {
            int btnWidth = (int)(alert_width/3);
            
            btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 1, btnWidth-1, btn_height)];
            [btnCancel setTag:1000];
            [btnCancel setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [btnCancel.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
            btnCancel.titleLabel.adjustsFontSizeToFitWidth = YES;
            btnCancel.titleLabel.minimumScaleFactor = 0.7;
            [btnCancel setBackgroundImage:imageWithColor(RGB(255, 255, 255)) forState:UIControlStateNormal];
            [btnCancel setBackgroundImage:imageWithColor(RGB(230, 238, 246)) forState:UIControlStateHighlighted];
            [btnCancel setTitleColor:RGB(29, 175, 226) forState:UIControlStateNormal];
            [btnCancel setTitleColor:RGB(29, 175, 226) forState:UIControlStateHighlighted];
            
            [btnCancel addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            btnCancel.isAccessibilityElement = YES;
            btnCancel.accessibilityTraits = UIAccessibilityTraitButton;
            
            btnOther = [[UIButton alloc] initWithFrame:CGRectMake(btnWidth, 1, btnWidth, btn_height)];
            [btnOther setTag:1001];
            [btnOther setTitle:otherButtonTitle forState:UIControlStateNormal];
            [btnOther.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
            btnOther.titleLabel.adjustsFontSizeToFitWidth = YES;
            btnOther.titleLabel.minimumScaleFactor = 0.7;
            [btnOther setBackgroundImage:imageWithColor(RGB(29, 175, 226)) forState:UIControlStateNormal];
            [btnOther setBackgroundImage:imageWithColor(RGB(19, 147, 200)) forState:UIControlStateHighlighted];
            [btnOther setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
            [btnOther setTitleColor:RGB(230, 238, 246) forState:UIControlStateHighlighted];
            
            [btnOther addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            btnOther.isAccessibilityElement = YES;
            btnOther.accessibilityTraits = UIAccessibilityTraitButton;
            
            btnOther2 = [[UIButton alloc] initWithFrame:CGRectMake(btnWidth*2+1, 1, btnWidth-1, btn_height)];
            [btnOther2 setTag:1002];
            [btnOther2 setTitle:otherButtonTitle2 forState:UIControlStateNormal];
            [btnOther2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
            btnOther2.titleLabel.adjustsFontSizeToFitWidth = YES;
            btnOther2.titleLabel.minimumScaleFactor = 0.7;
            [btnOther2 setBackgroundImage:imageWithColor(RGB(255, 255, 255)) forState:UIControlStateNormal];
            [btnOther2 setBackgroundImage:imageWithColor(RGB(230, 238, 246)) forState:UIControlStateHighlighted];
            [btnOther2 setTitleColor:RGB(29, 175, 226) forState:UIControlStateNormal];
            [btnOther2 setTitleColor:RGB(29, 175, 226) forState:UIControlStateHighlighted];
            
            
            [btnOther2 addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            btnOther2.isAccessibilityElement = YES;
            btnOther2.accessibilityTraits = UIAccessibilityTraitButton;
            
            alert_top += btnOther2.frame.size.height + 15.0;
        }
        else if (cancelButtonTitle && otherButtonTitle)
        {
            int btnWidth = (int)(alert_width/2);
            
            btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 1, btnWidth, btn_height)];
            [btnCancel setTag:1000];
            [btnCancel setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [btnCancel.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
            [btnCancel setBackgroundImage:imageWithColor(RGB(255, 255, 255)) forState:UIControlStateNormal];
            [btnCancel setBackgroundImage:imageWithColor(RGB(230, 238, 246)) forState:UIControlStateHighlighted];
            [btnCancel setTitleColor:RGB(29, 175, 226) forState:UIControlStateNormal];
            [btnCancel setTitleColor:RGB(29, 175, 226) forState:UIControlStateHighlighted];
            
            [btnCancel addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            btnCancel.isAccessibilityElement = YES;
            btnCancel.accessibilityTraits = UIAccessibilityTraitButton;
            
            btnOther = [[UIButton alloc] initWithFrame:CGRectMake(btnWidth+1, 1, btnWidth-1, btn_height)];
            [btnOther setTag:1001];
            [btnOther setTitle:otherButtonTitle forState:UIControlStateNormal];
            [btnOther.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
            [btnOther setBackgroundImage:imageWithColor(RGB(29, 175, 226)) forState:UIControlStateNormal];
            [btnOther setBackgroundImage:imageWithColor(RGB(19, 147, 200)) forState:UIControlStateHighlighted];
            [btnOther setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
            [btnOther setTitleColor:RGB(230, 238, 246) forState:UIControlStateHighlighted];
            
            [btnOther addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            btnOther.isAccessibilityElement = YES;
            btnOther.accessibilityTraits = UIAccessibilityTraitButton;
            
            alert_top += btnCancel.frame.size.height + 15.0;
        }
        else if (cancelButtonTitle)
        {
            btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 1, alert_width, btn_height)];
            [btnCancel setTag:1000];
            [btnCancel setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [btnCancel.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
            [btnCancel setBackgroundImage:imageWithColor(RGB(29, 175, 226)) forState:UIControlStateNormal];
            [btnCancel setBackgroundImage:imageWithColor(RGB(19, 147, 200)) forState:UIControlStateHighlighted];
            [btnCancel setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
            [btnCancel setTitleColor:RGB(230, 238, 246) forState:UIControlStateHighlighted];
            
            [btnCancel addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            btnCancel.isAccessibilityElement = YES;
            btnCancel.accessibilityTraits = UIAccessibilityTraitButton;
            
            alert_top += btnCancel.frame.size.height + 15.0;
        }
        else if (otherButtonTitle)
        {
            btnOther = [[UIButton alloc] initWithFrame:CGRectMake(0, 1, alert_width, btn_height)];
            [btnOther setTag:1001];
            [btnOther setTitle:otherButtonTitle forState:UIControlStateNormal];
            [btnOther.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
            [btnOther setBackgroundImage:imageWithColor(RGB(29, 175, 226)) forState:UIControlStateNormal];
            [btnOther setBackgroundImage:imageWithColor(RGB(19, 147, 200)) forState:UIControlStateHighlighted];
            [btnOther setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
            [btnOther setTitleColor:RGB(230, 238, 246) forState:UIControlStateHighlighted];
            
            [btnOther addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            btnOther.isAccessibilityElement = YES;
            btnOther.accessibilityTraits = UIAccessibilityTraitButton;
            
            alert_top += btnOther.frame.size.height + 15.0;
        }
        else
            alert_top += 15.0;
        
        //add background
        
        viewAlert = [[UIView alloc] initWithFrame:
                     CGRectMake((self.frame.size.width-alert_width)/2.0, (self.frame.size.height-alert_top)/2.0,
                                alert_width, alert_top)];
        viewAlert.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        viewAlert.backgroundColor = [UIColor whiteColor];
        
        // 타이틀 배경
        int iBGViewWidth = (int)viewAlert.frame.size.width;
        int iTitleViewHeight = 49;
        UIView *titleBGView = [[UIView alloc] initWithFrame:CGRectMake(0, -5, iBGViewWidth, iTitleViewHeight)];
        titleBGView.backgroundColor = RGB(255, 255, 255);
        [viewAlert addSubview:titleBGView];
        
        // 타이틀 BI
        NSInteger titleX = (iBGViewWidth - 208) / 2;
        NSInteger titleY = (iTitleViewHeight - 49) / 2;
        
        UIImageView *titleBIView = [[UIImageView alloc] initWithFrame:CGRectMake(titleX, titleY, 208, 49)];
        [titleBIView setContentMode:UIViewContentModeCenter];
        if (image == nil) {
            titleBIView.image = [UIImage imageNamed:@"img_logo"];
        }
        else {
            titleBIView.image = [UIImage imageNamed:image];
        }
        [titleBGView addSubview:titleBIView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 48, iBGViewWidth, 1)];
        lineView.backgroundColor = RGB(218, 218, 218);
        [titleBGView addSubview:lineView];
        
        
        UIView *btnBGView = [[UIView alloc] initWithFrame:CGRectMake(0, viewAlert.frame.size.height-41, iBGViewWidth, 41)];
        btnBGView.backgroundColor = RGB(255, 255, 255);
        [viewAlert addSubview:btnBGView];
        
        UIView *btnLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iBGViewWidth, 1)];
        if (cancelButtonTitle && otherButtonTitle)
        {
            btnLineView.backgroundColor = RGB(29, 175, 226);
        }
        else
        {
            btnLineView.backgroundColor = RGB(29, 175, 226);
        }
        
        [btnBGView addSubview:btnLineView];
        
        
        [self addSubview:viewAlert];
        
        
        if (lblTitle)
            [viewAlert addSubview:lblTitle];
        
        if (scrollViewMsg)
            [viewAlert addSubview:scrollViewMsg];
        
        if (btnCancel)
            [btnBGView addSubview:btnCancel];
        
        if (btnOther)
            [btnBGView addSubview:btnOther];
        
        if (btnOther2) {
            [btnBGView addSubview:btnOther2];
        }
    }
    return self;
}

- (void)onBtnPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    self.selectedButtonIndex = (int)(button.tag - 1000);
    
    [self animateHide];
}

- (void)show
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6f];
    
    self.center = CGPointMake(CGRectGetMidX(self.window.bounds), CGRectGetMidY(self.window.bounds));
    
    [self.window addSubview:self];
    [self.window makeKeyAndVisible];
    
    [self animateShow];
}

- (void)hide
{
    //NSLog(@"CustomAlertView closeView");
    
    self.selectedButtonIndex = 1000;
    
    [self removeView];
}

- (void)animateShow
{
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation
//                                      animationWithKeyPath:@"transform"];
//    
//    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
//    CATransform3D scale2 = CATransform3DMakeScale(1.1, 1.1, 1);
//    //    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
//    CATransform3D scale3 = CATransform3DMakeScale(1.0, 1.0, 1);
//    
//    NSArray *frameValues = [NSArray arrayWithObjects:
//                            [NSValue valueWithCATransform3D:scale1],
//                            [NSValue valueWithCATransform3D:scale2],
//                            [NSValue valueWithCATransform3D:scale3],
//                            //                            [NSValue valueWithCATransform3D:scale4],
//                            nil];
//    [animation setValues:frameValues];
//    
//    NSArray *frameTimes = [NSArray arrayWithObjects:
//                           [NSNumber numberWithFloat:0.0f],
//                           [NSNumber numberWithFloat:0.5f],
//                           //                           [NSNumber numberWithFloat:0.9f],
//                           [NSNumber numberWithFloat:1.0f],
//                           nil];
//    [animation setKeyTimes:frameTimes];
//    
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    animation.duration = 0.3;
//    
//    [viewAlert.layer addAnimation:animation forKey:@"show"];
    viewAlert.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        viewAlert.alpha = 1;
    }];
}

- (void)animateHide
{
    //NSLog(@"CustomAlertView animateHide");
    
    //    CAKeyframeAnimation *animation = [CAKeyframeAnimation
    //                                      animationWithKeyPath:@"transform"];
    //
    //    CATransform3D scale1 = CATransform3DMakeScale(1.0, 1.0, 1);
    //    CATransform3D scale2 = CATransform3DMakeScale(0.5, 0.5, 1);
    //    CATransform3D scale3 = CATransform3DMakeScale(0.0, 0.0, 1);
    //
    //    NSArray *frameValues = [NSArray arrayWithObjects:
    //                            [NSValue valueWithCATransform3D:scale1],
    //                            [NSValue valueWithCATransform3D:scale2],
    //                            [NSValue valueWithCATransform3D:scale3],
    //                            nil];
    //    [animation setValues:frameValues];
    //
    //    NSArray *frameTimes = [NSArray arrayWithObjects:
    //                           [NSNumber numberWithFloat:0.0f],
    //                           [NSNumber numberWithFloat:0.5f],
    //                           [NSNumber numberWithFloat:0.9f],
    //                           nil];
    //    [animation setKeyTimes:frameTimes];
    //
    //    animation.fillMode = kCAFillModeForwards;
    //    animation.removedOnCompletion = NO;
    //    animation.duration = 0.2;
    //
    //    [viewAlert.layer addAnimation:animation forKey:@"hide"];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:0 animations:^{
        viewAlert.alpha = 0.0;
        CATransform3D scale = CATransform3DMakeScale(0.3, 0.3, 1);
        [viewAlert.layer setTransform:scale];
    } completion:^(BOOL finished) {
        [self removeView];
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        viewAlert.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeView];
    }];
}

- (void)removeView {
    //NSLog(@"CustomAlertView removeView");
    NSInteger btnIndex = self.selectedButtonIndex;
    void(^handler)(NSInteger btnIndex) = comp_handler;
    
    self.window.hidden = YES;
    self.window = nil;
    [self removeFromSuperview];
    
    if (handler) {
        handler(btnIndex);
    }
}


@end

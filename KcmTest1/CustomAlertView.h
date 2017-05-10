//
//  CustomAlertView.h
//  KcmTest1
//
//  Created by openobject on 2017. 3. 15..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AlertTitle          @"알림"
#define AlertYes            @"예"
#define AlertNo             @"아니오"
#define AlertConfirm        @"확인"
#define AlertCancel         @"취소"

@interface CustomAlertView : UIView {
    UIView *viewAlert;
    UILabel *lblTitle;
    UILabel *lblMessage;
    UIButton *btnCancel;
    UIButton *btnOther;
    UIButton *btnOther2;
    void(^comp_handler)(NSInteger btnIndex);
}

@property (nonatomic) UIWindow * window;
@property (nonatomic) NSInteger selectedButtonIndex;

+ (void)showMessagePopup:(NSString*)message
                 handler:(void(^)(NSInteger btnIndex))onComp;

+ (void)showMessagePopup:(NSString*)message
       cancelButtonTitle:(NSString*)cancelButtonTitle
        otherButtonTitle:(NSString*)otherButtonTitle
                 handler:(void(^)(NSInteger btnIndex))onComp;

+ (void)showMessagePopup:(NSString*)message
              titleImage:(NSString*)image
       cancelButtonTitle:(NSString*)cancelButtonTitle
        otherButtonTitle:(NSString*)otherButtonTitle
       otherButtonTitle2:(NSString*)otherButtonTitle2
                 handler:(void(^)(NSInteger btnIndex))onComp;

- (void)show;

- (void)hide;

@end

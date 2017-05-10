//
//  PagingViewController.h
//  KcmTest1
//
//  Created by openobject on 2017. 2. 27..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagingViewController : UIViewController <UITextFieldDelegate>

@property (strong) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (weak, nonatomic) IBOutlet UITextField *id_Field;
@property (weak, nonatomic) IBOutlet UITextField *password_Field;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *btnView;

@end

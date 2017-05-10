//
//  PagingViewController.m
//  KcmTest1
//
//  Created by openobject on 2017. 2. 27..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "PagingViewController.h"

@interface PagingViewController ()

@end

@implementation PagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.6 animations:^{
        self.bottomConstraint.active = !self.bottomConstraint.isActive;
        [self.view layoutIfNeeded];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    [super viewWillDisappear:animated];
}

- (void)textFieldDidBeginEditing:(UITextField *)sender {
    if ([sender isEqual:self.id_Field] || [sender isEqual:self.password_Field]) {
        if  (self.btnView.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
        
    }
}

- (void) setViewMovedUp:(BOOL)movedUp {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    
    CGRect rect = self.btnView.frame;
    if (movedUp) {
        rect.origin.y -= 80;
    }else {
        rect.origin.y += 80;
    }
    
    self.btnView.frame = rect;
    [UIView commitAnimations];
}

- (void) keyboardWillShow {
    // Animate the current view out of the way
    if (self.btnView.frame.origin.y >= 0) {
        [self setViewMovedUp:YES];
    }else if (self.btnView.frame.origin.y < 0) {
        [self setViewMovedUp:NO];
    }
    
}

- (void) keyboardWillHide {
    
    if (self.btnView.frame.origin.y >= 0){
        
        [self setViewMovedUp:YES];
    }else if (self.btnView.frame.origin.y < 0) {
        
        [self setViewMovedUp:NO];
    }
}

@end

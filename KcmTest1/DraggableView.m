//
//  DraggableView.m
//  KcmTest1
//
//  Created by openobject on 2017. 4. 19..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "DraggableView.h"

@implementation DraggableView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    offset = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.superview];
    [UIView beginAnimations:@"Dragging DraggableView" context:nil];
    self.frame = CGRectMake(location.x - offset.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView beginAnimations:@"Cancel Dragging DraggableView" context:nil];
    self.frame = CGRectMake(offset.x, offset.y, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}

@end

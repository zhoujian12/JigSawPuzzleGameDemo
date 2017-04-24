//
//  UIView+frame.m
//  JigSawPuzzleGameDemo
//
//  Created by jianz3 on 2017/4/24.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)
#pragma mark - view + frame
- (CGFloat)frameX {
    return self.frame.origin.x;
}

- (CGFloat)frameY {
    return self.frame.origin.y;
}

- (CGFloat)frameWidth {
    return self.frame.size.width;
}

- (CGFloat)frameHeight {
    return self.frame.size.height;
}

- (void)setFrameX:(CGFloat)frameX {
    CGRect frame = self.frame;
    frame.origin.x = frameX;
    
    self.frame = frame;
}

- (void)setFrameY:(CGFloat)frameY {
    CGRect frame = self.frame;
    frame.origin.y = frameY;
    
    self.frame = frame;
}

- (void)setFrameWidth:(CGFloat)frameWidth {
    CGRect frame = self.frame;
    frame.size.width = frameWidth;
    
    self.frame = frame;
}

- (void)setFrameHeight:(CGFloat)frameHeight {
    CGRect frame = self.frame;
    frame.size.height = frameHeight;
    
    self.frame = frame;
}
@end

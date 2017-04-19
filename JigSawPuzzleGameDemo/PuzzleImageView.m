//
//  PuzzleImageView.m
//  PingtuDemo
//
//  Created by jianz3 on 2017/3/14.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import "PuzzleImageView.h"

@interface PuzzleImageView()

@property (nonatomic,strong)UIPanGestureRecognizer *pan;

@end

@implementation PuzzleImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (id) initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image]) {
        [self setUserInteractionEnabled:YES];//交互设置
        [self setMultipleTouchEnabled:YES];//多指触控
        self.layer.borderWidth = 1;//注意边框为1，来判断拼图是否能移动
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self addGestureRecognizer:self.pan];
}

- (UIPanGestureRecognizer *)pan{
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    }
    return _pan;
}

- (void)panAction:(UIPanGestureRecognizer *)pan{
//    UIImageView *imageView = (UIImageView *)[pan view];
    
    if (self.imageViewPanBlock) {
        self.imageViewPanBlock(pan);
    }
}

@end

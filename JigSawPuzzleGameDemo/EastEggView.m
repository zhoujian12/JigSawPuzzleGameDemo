//
//  EastEggView.m
//  EasterEggDemo
//
//  Created by jianz3 on 2017/3/13.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import "EastEggView.h"
#define kMainScreenWidth         ([UIScreen mainScreen].bounds).size.width              //屏幕的高度
#define kMainScreenHeight        ([UIScreen mainScreen].bounds).size.height             //屏幕的宽度

#define UIColorFromRGB(rgbValue)                                                                   \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                           \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                              \
blue:((float)(rgbValue & 0xFF)) / 255.0                                       \
alpha:1.0]

@interface EastEggView()

@property (nonatomic,strong)UIView *popUpView;///<弹窗视图

@property (nonatomic,strong)UITextView *popUpTextView;///<弹窗文本视图

@property (nonatomic,strong)UIButton *closeBtn;///<关闭按钮

@end

@implementation EastEggView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5f];
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self addSubview:self.popUpView];
    [self.popUpView addSubview:self.popUpTextView];
    [self.popUpView addSubview:self.closeBtn];
}

- (UIView *)popUpView{
    if (!_popUpView) {
        CGRect rect = CGRectMake((kMainScreenWidth - 200)/2, (kMainScreenHeight - 60)/2, 200, 60);
        _popUpView = [[UIView alloc]initWithFrame:rect];
        _popUpView.backgroundColor = UIColorFromRGB(0xFFFFFF);
        _popUpView.userInteractionEnabled = YES;
    }
    return _popUpView;
}

- (UITextView *)popUpTextView{
    if (!_popUpTextView) {
        CGRect rect = CGRectMake(0, 30, 200, 30);
        _popUpTextView = [[UITextView alloc]initWithFrame:rect];
        _popUpTextView.backgroundColor = [UIColor clearColor];
        _popUpTextView.textColor = [UIColor blackColor];
        _popUpTextView.font = [UIFont systemFontOfSize:12.0f];
        _popUpTextView.textAlignment = NSTextAlignmentCenter;
        _popUpTextView.editable = NO;
    }
    return _popUpTextView;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(self.popUpView.frame.size.width - 30, 5, 25, 25);
        _closeBtn.userInteractionEnabled = YES;
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"eastEgg_close_btn"] forState:UIControlStateNormal];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"eastEgg_close_btn"] forState:UIControlStateHighlighted];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"eastEgg_close_btn"] forState:UIControlStateSelected];

        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (void)setContentStr:(NSString *)contentStr{
    if (_contentStr != contentStr) {
        _contentStr = contentStr;
        self.popUpTextView.text = _contentStr;
    }
}

- (void)closeAction:(UIButton *)btn{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

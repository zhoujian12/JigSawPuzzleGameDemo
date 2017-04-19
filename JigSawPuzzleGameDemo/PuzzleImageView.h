//
//  PuzzleImageView.h
//  PingtuDemo
//
//  Created by jianz3 on 2017/3/14.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface PuzzleImageView : UIImageView

@property (assign, nonatomic) CGRect accurateFrame;///<window上切割图对应的坐标

@property (assign, nonatomic) CGRect originFrame;///<拼图区域内切割图对应的坐标

/**
 *  拼图单图拖动对应的回调
 */
@property (nonatomic ,copy) void(^imageViewPanBlock)(UIPanGestureRecognizer *pan);

@end

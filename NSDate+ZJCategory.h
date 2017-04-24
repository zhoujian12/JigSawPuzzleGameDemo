//
//  NSDate+ZJCategory.h
//  JigSawPuzzleGameDemo
//
//  Created by jianz3 on 2017/4/21.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZJCategory)

@property(nonatomic,assign,readonly)NSInteger year;
@property(nonatomic,assign,readonly)NSInteger month;
@property(nonatomic,assign,readonly)NSInteger day;
@property(nonatomic,assign,readonly)NSInteger hour;
@property(nonatomic,assign,readonly)NSInteger minute;
@property(nonatomic,assign,readonly)NSInteger seconds;
@property (nonatomic,assign,readonly)NSInteger weekday;

+(NSDate *)zj_dateWithDateString:(NSString *)dateString;

+(NSDate *)zj_dateWithFormat_yyyy_MM_dd_HH_mm_ss_string:(NSString *)string;
+(NSDate *)zj_dateWithFormat_yyyy_MM_dd_HH_mm_string:(NSString *)string;
+(NSDate *)zj_dateWithFormat_yyyy_MM_dd_HH_string:(NSString *)string;
+(NSDate *)zj_dateWithFormat_yyyy_MM_dd_string:(NSString *)string;
+(NSDate *)zj_dateWithFormat_yyyy_MM_string:(NSString *)string;

@end

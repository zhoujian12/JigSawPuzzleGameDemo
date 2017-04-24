//
//  NSString+ZJDateFormat.h
//  JigSawPuzzleGameDemo
//
//  Created by jianz3 on 2017/4/21.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZJDateFormat)

//时间字符串2017-04-16 13:08:06 ->转换

#pragma mark -年月日

/**
 *  x年x月x日
 */
@property(nonatomic,copy,readonly)NSString *zj_formatNianYueRi;

/**
 *  x年x月
 */
@property(nonatomic,copy,readonly)NSString *zj_formatNianYue;

/**
 *  x月x日
 */
@property(nonatomic,copy,readonly)NSString *zj_formatYueRi;

/**
 *  x年
 */
@property(nonatomic,copy,readonly)NSString *zj_formatNian;

/**
 *  x时x分x秒
 */
@property(nonatomic,copy,readonly)NSString *zj_formatShiFenMiao;

/**
 *  x时x分
 */
@property(nonatomic,copy,readonly)NSString *zj_formatShiFen;

/**
 *  x分x秒
 */
@property(nonatomic,copy,readonly)NSString *zj_formatFenMiao;

/**
 *  yyyy-MM-dd
 */
@property(nonatomic,copy,readonly)NSString *zj_format_yyyy_MM_dd;

/**
 *  yyyy-MM
 */
@property(nonatomic,copy,readonly)NSString *zj_format_yyyy_MM;

/**
 *  MM-dd
 */
@property(nonatomic,copy,readonly)NSString *zj_format_MM_dd;

/**
 *  yyyy
 */
@property(nonatomic,copy,readonly)NSString *zj_format_yyyy;

/**
 *  HH:mm:ss
 */
@property(nonatomic,copy,readonly)NSString *zj_format_HH_mm_ss;

/**
 *  HH:mm
 */
@property(nonatomic,copy,readonly)NSString *zj_format_HH_mm;

/**
 *  mm:ss
 */
@property(nonatomic,copy,readonly)NSString *zj_format_mm_ss;

#pragma mark - 转换为星期几
@property(nonatomic,copy,readonly)NSString *zj_formatWeekDay;

@end

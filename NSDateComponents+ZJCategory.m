//
//  NSDateComponents+ZJCategory.m
//  JigSawPuzzleGameDemo
//
//  Created by jianz3 on 2017/4/21.
//  Copyright © 2017年 jianz3. All rights reserved.
//

/*
NSCalendarUnit包含的值有：
NSCalendarUnitEra                 -- 纪元单位。对于 NSGregorianCalendar (公历)来说，只有公元前(BC)和公元(AD)；
而对于其它历法可能有很多，例如日本和历是以每一代君王统治来做计算。
NSCalendarUnitYear                -- 年单位。值很大，相当于经历了多少年，未来多少年。
NSCalendarUnitMonth               -- 月单位。范围为1-12
NSCalendarUnitDay                 -- 天单位。范围为1-31
NSCalendarUnitHour                -- 小时单位。范围为0-24
NSCalendarUnitMinute              -- 分钟单位。范围为0-60
NSCalendarUnitSecond              -- 秒单位。范围为0-60
NSCalendarUnitWeekOfMonth / NSCalendarUnitWeekOfYear -- 周单位。范围为1-53
NSCalendarUnitWeekday             -- 星期单位，每周的7天。范围为1-7
NSCalendarUnitWeekdayOrdinal      -- 没完全搞清楚
NSCalendarUnitQuarter             -- 几刻钟，也就是15分钟。范围为1-4
NSCalendarUnitWeekOfMonth         -- 月包含的周数。最多为6个周
NSCalendarUnitWeekOfYear          -- 年包含的周数。最多为53个周
NSCalendarUnitYearForWeekOfYear   -- 没完全搞清楚
NSCalendarUnitTimeZone            -- 没完全搞清楚
*/


#import "NSDateComponents+ZJCategory.h"

@implementation NSDateComponents (ZJCategory)

+(NSDateComponents *)zj_dateComponentsFromDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal fromDate:date];
    return components;
    
}
@end

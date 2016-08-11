//
//  NSDate+LCCalendar.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/11.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "NSDate+LCCalendar.h"

@implementation NSDate (LCCalendar)

- (NSUInteger )lc_day{
    NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay fromDate:self];
    return comp.day;
}

- (NSUInteger )lc_daysOfMonth{
    NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}

- (NSUInteger )lc_weekDay{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *comp = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return comp.weekday;
}

- (NSDate *)lc_firstDayOfMonth{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    comp.day = 1;
    return [calendar dateFromComponents:comp];
}

- (NSDate *)lc_lastDayOfMonth{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    comp.day = [self lc_daysOfMonth];
    return [calendar dateFromComponents:comp];
}

- (NSString *)lc_chineseDay{
    NSArray *chineseMonths = @[
                               @"正月", @"二月", @"三月", @"四月",
                               @"五月", @"六月", @"七月", @"八月",
                               @"九月", @"十月", @"冬月", @"腊月"
                               ];
    NSArray *chineseDays = @[
                            @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                            @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                            @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"
                            ];

    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    NSString *dayStr = [chineseDays objectAtIndex:comp.day - 1];
    if (comp.day == 1) {
        dayStr = chineseMonths[comp.month - 1];
    }
    
    return dayStr;
}
@end

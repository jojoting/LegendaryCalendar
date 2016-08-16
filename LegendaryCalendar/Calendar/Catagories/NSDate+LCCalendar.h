//
//  NSDate+LCCalendar.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/11.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LCCalendar)

- (NSArray<NSDate *> *)lc_currentDates;
- (NSArray<NSDate *> *)lc_preMonthDates;
- (NSArray<NSDate *> *)lc_nextMonthDates;

- (NSUInteger )lc_day;
- (NSUInteger )lc_daysOfMonth;
- (NSUInteger )lc_weekDay;
- (NSUInteger )lc_lastMonth;
- (NSUInteger )lc_nextMonth;
- (NSUInteger )lc_currentMonth;
- (NSUInteger )lc_year;

- (NSDate *)lc_firstDayOfMonth;
- (NSDate *)lc_lastDayOfMonth;
- (NSDate *)lc_dateOfMonthsToCurrentMonth:(NSInteger )monthsToCurrentMonth;

- (NSString *)lc_chineseDay;

- (BOOL)lc_isFestival;
- (BOOL)lc_isCurrentMonth;
- (BOOL)lc_isMonth:(NSUInteger )month;
- (BOOL)lc_isCurrentDay;

@end

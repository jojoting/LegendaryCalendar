//
//  NSDate+LCCalendar.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/11.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LCCalendar)

- (NSUInteger )lc_day;
- (NSUInteger )lc_daysOfMonth;
- (NSUInteger )lc_weekDay;
- (NSDate *)lc_firstDayOfMonth;
- (NSDate *)lc_lastDayOfMonth;
- (NSString *)lc_chineseDay;

@end

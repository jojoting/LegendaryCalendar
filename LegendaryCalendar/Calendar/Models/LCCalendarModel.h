//
//  LCCalendarModel.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCCalendarModel : NSObject

@property (nonatomic, copy  ) NSArray<NSDate *> *currentMonth_days;
@property (nonatomic, copy  ) NSArray<NSDate *> *preMonth_days;
@property (nonatomic, copy  ) NSArray<NSDate *> *nextMonth_days;
@property (nonatomic, assign) NSUInteger         currentMonth;
@property (nonatomic, assign) NSUInteger         currentYear;

@end

//
//  LCCalendarModel.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarModel.h"

@implementation LCCalendarModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentMonth_days = [NSArray array];
        self.preMonth_days = [NSArray array];
        self.nextMonth_days = [NSArray array];
    }
    return self;
}
@end

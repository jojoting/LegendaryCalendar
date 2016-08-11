//
//  LCCalendarCellModel.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/11.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarCellModel.h"
#import "NSDate+LCCalendar.h"

@interface LCCalendarCellModel (){
    NSDate *_date;
}

@end

@implementation LCCalendarCellModel

+ (instancetype)cellModelWithDate:(NSDate *)date{
    return [[self alloc] initWithDate:date];
}

- (instancetype)initWithDate:(NSDate *)date{
    self = [super init];
    if (self) {
        _date = date;
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.dateStr = [NSString stringWithFormat:@"%ld", [_date lc_day]];
}

@end

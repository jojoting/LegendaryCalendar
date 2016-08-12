//
//  LCCalendarCellModel.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/11.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarCellModel.h"
#import "NSDate+LCCalendar.h"

@interface LCCalendarCellModel ()
@end

@implementation LCCalendarCellModel

+ (instancetype)cellModelWithDate:(NSDate *)date{
    return [[self alloc] initWithDate:date];
}

- (instancetype)initWithDate:(NSDate *)date{
    self = [super init];
    if (self) {
        [self setUpWithDate:date];
    }
    return self;
}

- (void)setUpWithDate:(NSDate *)date{
    
}

@end

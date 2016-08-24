//
//  LCCalendar.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/20.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  LCCalendar;
@protocol LCCalendarDelegate <NSObject>

@optional
- (void)calendar:(LCCalendar *)calendar didSelectDate:(NSDate *)date;

@end

@interface LCCalendar : UIView

@end

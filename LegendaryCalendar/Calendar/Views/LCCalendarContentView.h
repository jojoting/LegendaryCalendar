//
//  LCCalendarContentView.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCCalendarContentView : UIView

- (void)loadWithMonthsToCurrrentMonth:(NSInteger )monthsToCurrrentMonth;
- (void)selectDate:(NSDate *)date;

@end

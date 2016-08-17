//
//  LCCalendarTitleView.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCCalendarTitleView : UIView

@property (nonatomic, assign) NSUInteger    year;
@property (nonatomic, assign) NSUInteger    month;

- (void)updateWithYear:(NSUInteger )year month:(NSUInteger )month;

@end

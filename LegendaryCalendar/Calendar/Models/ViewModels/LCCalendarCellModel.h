//
//  LCCalendarCellModel.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/11.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LCCalendarCellModel : NSObject

@property (nonatomic, copy) NSAttributedString    *dateStr;
@property (nonatomic, copy) NSAttributedString    *chineseDateStr;
@property (nonatomic, strong) UIColor             *backgroundColor;

+ (instancetype)cellModelWithDate:(NSDate *)date month:(NSUInteger )month;

@end

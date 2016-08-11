//
//  LCCalendarCellModel.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/11.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCCalendarCellModel : NSObject

@property (nonatomic, copy) NSString              *dateStr;
@property (nonatomic, copy) NSAttributedString    *chineseDateStr;

+ (instancetype)cellModelWithDate:(NSDate *)date;

@end

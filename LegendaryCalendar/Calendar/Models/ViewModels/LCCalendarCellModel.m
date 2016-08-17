//
//  LCCalendarCellModel.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/11.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarCellModel.h"
#import "NSDate+LCCalendar.h"


typedef NS_ENUM(NSInteger, LCCalendarCellType) {
    LCCalendarCellTypeNormal = 0,
    LCCalendarCellTypeToday,
    LCCalendarCellTypeFestivalAndNotToday
};
@interface LCCalendarCellModel ()
@end

@implementation LCCalendarCellModel

+ (instancetype)cellModelWithDate:(NSDate *)date month:(NSUInteger )month {
    return [[self alloc] initWithDate:date month:month];
}

- (instancetype)initWithDate:(NSDate *)date month:(NSUInteger )month {
    self = [super init];
    if (self) {
        [self setUpWithDate:date month:month];
    }
    return self;
}

- (void)setUpWithDate:(NSDate *)date month:(NSUInteger )month {
    if ([date lc_isMonth:month]) {
        [self setUpDateWithCurrentMonth:date];
    } else {
        [self setUpDateNextOrLastMonth:date];
    }
}

- (void)setUpDateNextOrLastMonth:(NSDate *)date{
    [self setUpWithCellType:LCCalendarCellTypeNormal dayStr:[NSString stringWithFormat:@"%ld",[date lc_day]] chineseDayStr:[date lc_chineseDay] isCurrentMonth:NO];
}

- (void)setUpDateWithCurrentMonth:(NSDate *)date{
    LCCalendarCellType cellType = LCCalendarCellTypeNormal;
    
    //是否今日
    BOOL isCurrentDate = [date lc_isCurrentDay];
    if (isCurrentDate) {
        cellType = LCCalendarCellTypeToday;
    }
    //是否节日、节气或者初一
    if ([date lc_isFestival] && !isCurrentDate) {
        cellType = LCCalendarCellTypeFestivalAndNotToday;
    }
    [self setUpWithCellType:cellType dayStr:[NSString stringWithFormat:@"%ld",[date lc_day]] chineseDayStr:[date lc_chineseDay] isCurrentMonth:YES];
}

- (void)setUpWithCellType:(LCCalendarCellType )cellType dayStr:(NSString *)dayStr chineseDayStr:(NSString *)chineseDayStr isCurrentMonth:(BOOL )isCurrentMonth {
    //初始化富文本样式
    NSMutableDictionary *chineseDateAttrDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *dateAttrDict = [NSMutableDictionary dictionary];
    
    //初始配置
    chineseDateAttrDict[NSFontAttributeName] = [UIFont systemFontOfSize:8.f];
    dateAttrDict[NSFontAttributeName] = [UIFont systemFontOfSize:18.f];
    dateAttrDict[NSForegroundColorAttributeName] = COLOR_HEX(0x2d2d2d, 1.0);
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    dateAttrDict[NSParagraphStyleAttributeName] = paragraph;
    chineseDateAttrDict[NSParagraphStyleAttributeName] = paragraph;
    
    //初始化背景颜色
    self.backgroundColor = [UIColor clearColor];
    
    if (isCurrentMonth) {
        //根据类型改变样式
        switch (cellType) {
            case LCCalendarCellTypeNormal:
            {
                chineseDateAttrDict[NSForegroundColorAttributeName] = COLOR_HEX(0xcccccc, 1.0);
            }
                break;
            case LCCalendarCellTypeToday:
            {
                chineseDateAttrDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
                dateAttrDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
                self.backgroundColor = COLOR_HEX(0xffa800, 1.0);
            }
                break;
            case LCCalendarCellTypeFestivalAndNotToday:
            {
                chineseDateAttrDict[NSForegroundColorAttributeName] = COLOR_HEX(0xffa800, 1.0);
            }
                break;
            default:
                break;
        }
        
    } else {
        dateAttrDict[NSForegroundColorAttributeName] = COLOR_HEX(0x939393, 1.0);
        chineseDateAttrDict[NSForegroundColorAttributeName] = COLOR_HEX(0xcccccc, 0.7);
    }
    self.chineseDateStr = [[NSAttributedString alloc] initWithString:chineseDayStr attributes:chineseDateAttrDict];
    self.dateStr = [[NSAttributedString alloc] initWithString:dayStr attributes:dateAttrDict];
    
}
@end

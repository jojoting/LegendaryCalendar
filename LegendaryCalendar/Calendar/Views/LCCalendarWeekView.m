//
//  LCCalendarWeekView.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarWeekView.h"
#define WeekDayStr  @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"]

@interface LCCalendarWeekView () {
    NSMutableArray  *_weekDayLabels;
    CGFloat          _weekDayLabelWidth;
}

@end

@implementation LCCalendarWeekView

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWeekDayLabels];
    }
    return self;
}

- (void)initWeekDayLabels{
    _weekDayLabels = [NSMutableArray arrayWithCapacity:7];
    for (NSUInteger i = 0; i < 7; i ++) {
        _weekDayLabels[i] = [self weekDayLabelWithWeekDay:i];
        [self addSubview:_weekDayLabels[i]];
    }
}

- (void)layoutSubviews{
    _weekDayLabelWidth = self.frame.size.width / 7;
    for (NSUInteger i = 0; i < 7; i ++) {
        ((UILabel *)_weekDayLabels[i]).frame = CGRectMake(_weekDayLabelWidth *(i) , 0, _weekDayLabelWidth, self.frame.size.height);
    }
}

- (UILabel *)weekDayLabelWithWeekDay:(NSUInteger )weekDayIndex{
    UILabel  *weekDayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    weekDayLabel.textAlignment = NSTextAlignmentCenter;
    weekDayLabel.text = WeekDayStr[weekDayIndex];
    weekDayLabel.textColor = COLOR_HEX(0xcccccc, 1.0);
    weekDayLabel.font = [UIFont systemFontOfSize:11.f];
    
    return weekDayLabel;
}
@end

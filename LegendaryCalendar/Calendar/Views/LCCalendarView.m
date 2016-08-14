//
//  LCCalendarView.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarView.h"

@interface LCCalendarView (){
    NSMutableArray  *_contentViews;
    CGFloat          _contentViewWidth;
    CGFloat          _contentViewHeight;
}
@end

@implementation LCCalendarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    _contentViews = [NSMutableArray array];
    
}
- (void)loadNextMonth{
    
}
- (void)loadPreMonth{
    
}
@end

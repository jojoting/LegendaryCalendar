//
//  LCCalendarView.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarView.h"
#import "LCCalendarContentView.h"
#import "NSDate+LCCalendar.h"

const int maximum_content_views = 5;

@interface LCCalendarView () <UIScrollViewDelegate> {
    NSDate                  *_currentDisplayDate;
    UIScrollView            *_scrollView;
    NSMutableArray          *_contentViews;
    CGFloat                  _contentViewWidth;
    CGFloat                  _contentViewHeight;
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
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scrollView.contentSize = CGSizeMake(maximum_content_views * self.frame.size.width, self.frame.size.height);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator =NO;
    
    for (NSInteger i = 0; i < maximum_content_views; i ++) {
        LCCalendarContentView *contentView = [[LCCalendarContentView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        contentView.tag = i - 2; //tag为视图展示月份与当前月份之差
        [contentView loadWithMonthsToCurrrentMonth:contentView.tag];

        [_scrollView addSubview:contentView];
        [_contentViews addObject:contentView];
    }
    
    _currentDisplayDate = [[NSDate date] lc_dateOfMonthsToCurrentMonth:((LCCalendarView *)_contentViews[2]).tag];
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:NO];
    [self addSubview:_scrollView];
}

#pragma mark - public methods
- (void)loadNextMonth{
    for (LCCalendarContentView *contentView in _contentViews) {
        contentView.tag += 1;
        [contentView loadWithMonthsToCurrrentMonth:contentView.tag];
    }
    _currentDisplayDate = [[NSDate date] lc_dateOfMonthsToCurrentMonth:((LCCalendarView *)_contentViews[2]).tag];
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:NO];
    
}
- (void)loadPreMonth{
    for (LCCalendarContentView *contentView in _contentViews) {
        contentView.tag -= 1;
        [contentView loadWithMonthsToCurrrentMonth:contentView.tag];
    }
    _currentDisplayDate = [[NSDate date] lc_dateOfMonthsToCurrentMonth:((LCCalendarView *)_contentViews[2]).tag];
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:NO];
}

- (void)loadMonth:(NSInteger )month year:(NSInteger )year{
    NSInteger monthsToCurrentDisplayDate = [_currentDisplayDate lc_monthsToMonth:month year:year];
    for (LCCalendarContentView *contentView in _contentViews) {
        contentView.tag += monthsToCurrentDisplayDate;
        [contentView loadWithMonthsToCurrrentMonth:contentView.tag];
    }
    _currentDisplayDate = [[NSDate date] lc_dateOfMonth:month year:year];
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:NO];
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    scrollView.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //向前翻页
    if (scrollView.contentOffset.x == scrollView.frame.size.width) {
        [self loadPreMonth];
    }
    //向后翻页
    if (scrollView.contentOffset.x == scrollView.frame.size.width * 3) {
        [self loadNextMonth];
    }
//    scrollView.userInteractionEnabled = YES;
}
@end

//
//  LCCalendarView.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarView.h"
#import "LCCalendarContentView.h"
#import "LCCalendarTitleView.h"
#import "LCCalendarWeekView.h"
#import "NSDate+LCCalendar.h"

const CGFloat _titleViewHeight = 40.f;
const CGFloat _titleViewWidth = 120.f;
const CGFloat _weekViewHeight = 25.f;
const int maximum_content_views = 5;

@interface LCCalendarView () <UIScrollViewDelegate>

@property (nonatomic, strong) LCCalendarTitleView   *titleView;
@property (nonatomic, strong) LCCalendarWeekView    *weekView;
@property (nonatomic, strong) UIScrollView          *scrollView;


@end

@implementation LCCalendarView {
    NSDate                  *_currentDisplayDate;
    CGFloat                  _contentViewWidth;
    CGFloat                  _contentViewHeight;
    NSMutableArray<LCCalendarContentView *> *_contentViews;
}

#pragma mark - public methods
- (void)loadNextMonth{
    [self reloadWithMontnsToCurrentMonths:1 animated:NO];
}
- (void)loadPreMonth{
    [self reloadWithMontnsToCurrentMonths:-1 animated:NO];
}

- (void)loadMonth:(NSInteger )month year:(NSInteger )year animated:(BOOL)animated{
    NSInteger monthsToCurrentDisplayDate = [_currentDisplayDate lc_monthsToMonth:month year:year];
    [self reloadWithMontnsToCurrentMonths:monthsToCurrentDisplayDate animated:animated];
}

- (void)selectDate:(NSDate *)date {
    [_contentViews[2] selectDate:date];
}

#pragma mark - init
- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}
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
    
    
    for (NSInteger i = 0; i < maximum_content_views; i ++) {
        LCCalendarContentView *contentView = [[LCCalendarContentView alloc] initWithFrame:CGRectZero];
        contentView.tag = i - 2; //tag为视图展示月份与当前月份之差
        [contentView loadWithMonthsToCurrrentMonth:contentView.tag];

        [self.scrollView addSubview:contentView];
        [_contentViews addObject:contentView];
    }
    
    [self addSubview:self.titleView];
    [self addSubview:self.weekView];
    [self addSubview:self.scrollView];
    [self layoutIfNeeded];
    
    _currentDisplayDate = [NSDate date];
    [((LCCalendarContentView *)_contentViews[2]) selectDate:_currentDisplayDate];
}

#pragma mark - layout
- (void)layoutSubviews{
    self.titleView.frame = CGRectMake((self.frame.size.width - _titleViewWidth) / 2, 0, _titleViewWidth, _titleViewHeight);
    self.weekView.frame = CGRectMake(0, _titleViewHeight, self.frame.size.width, _weekViewHeight);
    self.scrollView.frame = CGRectMake(0, _titleViewHeight + _weekViewHeight, self.frame.size.width, self.frame.size.height - _weekViewHeight - _titleViewHeight);
    self.scrollView.contentSize = CGSizeMake(maximum_content_views * self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    for (int i = 0; i < maximum_content_views; i ++) {
        LCCalendarContentView *contentView = (LCCalendarContentView *)_contentViews[i];
        contentView.frame = CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    }
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * 2, 0) animated:NO];
}

#pragma mark - private methods

- (void)reloadWithMontnsToCurrentMonths:(NSInteger )monthsToCurrent animated:(BOOL)animated{
    for (LCCalendarContentView *contentView in _contentViews) {
        contentView.tag += monthsToCurrent;
        [contentView loadWithMonthsToCurrrentMonth:contentView.tag];
    }
    
    //选择年月的向左滑动画效果
    if (animated) {
        //先移动到目标页前一页,再向后移一页
        [_scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width , 0) animated:NO];
        [_scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * 2, 0) animated:YES];
    } else {
        [_scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * 2, 0) animated:NO];
    }
    _currentDisplayDate = [[NSDate date] lc_dateOfMonthsToCurrentMonth:((LCCalendarContentView *)_contentViews[2]).tag];
    [((LCCalendarContentView *)_contentViews[2]) selectDate:_currentDisplayDate];
    [self.titleView updateWithYear:[_currentDisplayDate lc_year] month:[_currentDisplayDate lc_currentMonth]];
}

- (void)titleViewTap:(UITapGestureRecognizer *)tap{
    [[NSNotificationCenter defaultCenter] postNotificationName:LCCalendarSelectMonthAndYearNotify
                                                        object:nil
                                                      userInfo:@{LCCalendarSelectMonthAndYearNotifyInfoYear:@(self.titleView.year),
                                                                 LCCalendarSelectMonthAndYearNotifyInfoMonth:@(self.titleView.month)
                                                                 }];
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

#pragma mark - getter

- (LCCalendarTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[LCCalendarTitleView alloc] init];
        NSDate *currentDate = [NSDate date];
        [_titleView updateWithYear:[currentDate lc_year] month: [currentDate lc_currentMonth]];
        [_titleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewTap:)]];
    }
    return _titleView;
}

- (LCCalendarWeekView *)weekView{
    if (!_weekView) {
        _weekView = [[LCCalendarWeekView alloc] init];
    }
    return _weekView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator =NO;
    }
    return _scrollView;
}
@end

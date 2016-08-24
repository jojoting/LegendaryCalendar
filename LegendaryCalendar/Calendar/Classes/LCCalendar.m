//
//  LCCalendar.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/20.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendar.h"
#import "LCCalendarTitleView.h"
#import "LCCalendarWeekView.h"
#import "NSDate+LCCalendar.h"
#import "LCCalendarCell.h"
#import "LCCalendarModel.h"
#import "LCCalendarCellModel.h"

#define MAX_BUFFER_SIZE 5

@interface NSMutableArray (LCQueue)

- (id)dequeue;
- (void)enqueue:(id)obj;

@end

@implementation NSMutableArray (LCQueue)

- (id)dequeue{
    id firstObj = [[self firstObject] copy];
    if (nil != firstObj) {
        [self removeObjectAtIndex:0];
    }
    return firstObj;
}

- (void)enqueue:(id)obj{
    [self addObject:obj];
}

@end

@interface LCCalendar () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) LCCalendarTitleView   *titleView;
@property (nonatomic, strong) LCCalendarWeekView    *weekView;
@property (nonatomic, strong) UICollectionView      *collectionView;


@end

const CGFloat kTitleViewHeight = 40.f;
const CGFloat kWeekViewHeight = 25.f;
const CGFloat kRowHeight = 60;
const NSUInteger kMinimumYear = 1900;
const NSUInteger kMaximumYear = 2100;

static NSString * const _cellIdentifier = @"LCCalendarCell";

@implementation LCCalendar {
    NSMutableArray<NSDate *>            *_datesOfCurrentMonth;
    NSMutableArray<NSMutableArray *>    *_bufferOfNext;
    NSMutableArray<NSMutableArray *>    *_bufferOfPre;
    NSDate  *_currentDate;
    CGFloat  _currentOffsetX;
    NSInteger   _currentPage;
}

#pragma mark - public

- (void)loadWithMonthsToCurrrentMonth:(NSInteger )monthsToCurrrentMonth{
    
}

- (void)reloadWithMonth:(NSUInteger )month year:(NSUInteger )year{
    NSInteger toPage = month + (year - kMinimumYear) * 12;
    NSInteger offset = (toPage - _currentPage) * self.collectionView.frame.size.width;
    [self.collectionView setContentOffset:CGPointMake(offset * self.collectionView.frame.size.width, 0) animated:NO];
}
#pragma mark - private methods

- (void)loadNextPage{
    _currentPage += 1;
    [_bufferOfNext dequeue];
    NSDate *date = [[[_bufferOfNext lastObject] objectAtIndex:15] lc_dateOfMonthsToCurrentMonth:1];
    [_bufferOfNext enqueue: [self datesWithMonth:[date lc_currentMonth] year:[date lc_year]]];
}


- (void)loadPrePage{
    _currentPage -= 1;
    [_bufferOfPre dequeue];
    NSDate *date = [[[_bufferOfPre lastObject] objectAtIndex:15] lc_dateOfMonthsToCurrentMonth:-1];
    [_bufferOfPre enqueue: [self datesWithMonth:[date lc_currentMonth] year:[date lc_year]]];

}

- (void)reloadBuffer{
    if(!_bufferOfNext){
        _bufferOfNext = [NSMutableArray arrayWithCapacity:MAX_BUFFER_SIZE];
    }
    if (!_bufferOfPre) {
        _bufferOfPre = [NSMutableArray arrayWithCapacity:MAX_BUFFER_SIZE];
    }
    [_bufferOfPre removeAllObjects];
    [_bufferOfNext removeAllObjects];

    for (int i = 0; i < MAX_BUFFER_SIZE; i ++) {
        NSDate *tempDate = [_currentDate lc_dateOfMonthsToCurrentMonth:i];
        [_bufferOfNext addObject:[self datesWithMonth:[tempDate lc_currentMonth] year:[tempDate lc_year]]];
    }
    for (int i = 0; i < MAX_BUFFER_SIZE; i ++) {
        NSDate *tempDate = [_currentDate lc_dateOfMonthsToCurrentMonth:-i];
        [_bufferOfPre addObject:[self datesWithMonth:[tempDate lc_currentMonth] year:[tempDate lc_year]]];
    }

    _datesOfCurrentMonth = [_bufferOfNext lastObject];
}

- (NSMutableArray *)datesWithMonth:(NSInteger )month year:(NSUInteger )year{
    NSDate *date = [NSDate lc_dateOfMonth:month year:year];
    
    NSMutableArray *dates = [NSMutableArray array];
    [dates addObjectsFromArray:[date lc_preMonthDates]];
    [dates addObjectsFromArray:[date lc_currentDates]];
    [dates addObjectsFromArray:[date lc_nextMonthDates]];
    return  dates;
}

- (void)titleViewTap:(UITapGestureRecognizer *)tap{
    [[NSNotificationCenter defaultCenter] postNotificationName:LCCalendarSelectMonthAndYearNotify
                                                        object:nil
                                                      userInfo:@{LCCalendarSelectMonthAndYearNotifyInfoYear:@(self.titleView.year),
                                                                 LCCalendarSelectMonthAndYearNotifyInfoMonth:@(self.titleView.month)
                                                                 }];
}

- (LCCalendarCell *)reloadDataWithCell:(LCCalendarCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    NSInteger month = indexPath.section % 12;
    NSUInteger rows = indexPath.item % 6;
    NSUInteger columns = indexPath.item / 6;
    
    NSUInteger date_index = rows * 7 + columns;
    NSInteger buffer_index = indexPath.section - _currentPage;
    NSArray *dates = [NSArray array];
    if (buffer_index >= 0) {
        dates = _bufferOfNext[buffer_index];
    } else if (buffer_index < 0) {
        dates = _bufferOfPre[- buffer_index];
    }
    LCCalendarCellModel *cellModel = [LCCalendarCellModel cellModelWithDate:dates[date_index]
                                                                      month:month];
    [cell setCellModel:cellModel];

    return cell;
}
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    self.backgroundColor = [UIColor whiteColor];
//    [self addSubview:self.titleView];
//    [self addSubview:self.weekView];
    _datesOfCurrentMonth = [NSMutableArray array];
    _currentDate = [NSDate date];
    _currentOffsetX = 0.f;
    [self reloadBuffer];
    [self addSubview:self.collectionView];
    [self reloadWithMonth:[_currentDate lc_currentMonth] year:[_currentDate lc_year]];
//    [self loadWithMonthsToCurrrentMonth:0];
}

#pragma mark - layout
- (void)layoutSubviews{
    self.titleView.frame = CGRectMake(0, 0, self.frame.size.width, kTitleViewHeight);
    self.weekView.frame = CGRectMake(0, kTitleViewHeight, self.frame.size.width, kWeekViewHeight);
    self.collectionView.frame = CGRectMake(0, kTitleViewHeight + kWeekViewHeight, self.frame.size.width, kRowHeight * _datesOfCurrentMonth.count / 7);
}

#pragma mark - UICollectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return (kMaximumYear - kMinimumYear) * 12;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger )section {
    NSUInteger year = (section/12 + 1) *kMinimumYear;
    NSUInteger month = (section%12 + 1);
    return [NSDate lc_numbersOfDateWithYear:year month:month];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"section : %ld",indexPath.section);
    LCCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[LCCalendarCell alloc] init];
    }
    cell = [self reloadDataWithCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewFlowLayout delegate
////设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_W/7.f, kRowHeight);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0
    ;
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x ;
    if (offsetX > _currentOffsetX) {

    }
    else if (offsetX < _currentOffsetX){

    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x ;
    //向后翻页
    if (offsetX > _currentOffsetX) {
        [self loadNextPage];
    }
    //向前翻页
    else if (offsetX < _currentOffsetX) {
        [self loadPrePage];
    }
    _currentOffsetX = offsetX;
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

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[LCCalendarCell class] forCellWithReuseIdentifier:_cellIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
    }
    return _collectionView;
}



@end

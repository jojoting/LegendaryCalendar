//
//  LCCalendarContentView.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarContentView.h"
#import "LCCalendarTitleView.h"
#import "LCCalendarWeekView.h"
#import "NSDate+LCCalendar.h"
#import "LCCalendarHandler.h"
#import "LCCalendarCell.h"
#import "LCCalendarModel.h"

const CGFloat _titleViewHeight = 40.f;
const CGFloat _weekViewHeight = 25.f;
static NSString * const _cellIdentifier = @"LCCalendarCell";

@interface LCCalendarContentView ()

@property (nonatomic, strong) LCCalendarTitleView   *titleView;
@property (nonatomic, strong) LCCalendarWeekView    *weekView;
@property (nonatomic, strong) UICollectionView      *collectionView;
@property (nonatomic, strong) LCCalendarHandler     *handler;
@end

@implementation LCCalendarContentView

#pragma mark - public

- (void)loadWithMonthsToCurrrentMonth:(NSInteger )monthsToCurrrentMonth{
    [self updateDataWithMonths:monthsToCurrrentMonth];
}

#pragma mark - private methods
- (void)updateDataWithMonths:(NSInteger )months{
    WEAKSELF
    [self.handler updateDataWithMonthsToCurrrentMonth:months CompletionBlock:^(LCCalendarModel *model) {
        STRONGSELF
        [strongSelf.titleView updateWithYear:model.currentYear month:model.currentMonth];
        [strongSelf.collectionView reloadData];
    }];
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
    [self addSubview:self.titleView];
    [self addSubview:self.weekView];
    [self addSubview:self.collectionView];
    
    [self loadWithMonthsToCurrrentMonth:0];
}

#pragma mark - layout
- (void)layoutSubviews{
    self.titleView.frame = CGRectMake(0, 0, self.frame.size.width, _titleViewHeight);
    self.weekView.frame = CGRectMake(0, _titleViewHeight, self.frame.size.width, _weekViewHeight);
    self.collectionView.frame = CGRectMake(0, _titleViewHeight + _weekViewHeight, self.frame.size.width, self.frame.size.height - _weekViewHeight - _titleViewHeight);
}
#pragma mark - getter
- (LCCalendarTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[LCCalendarTitleView alloc] init];
        NSDate *currentDate = [NSDate date];
        [_titleView updateWithYear:[currentDate lc_year] month: [currentDate lc_currentMonth]];
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
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
            _collectionView.delegate = self.handler;
            _collectionView.dataSource = self.handler;
            [_collectionView registerClass:[LCCalendarCell class] forCellWithReuseIdentifier:_cellIdentifier];
            _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (LCCalendarHandler *)handler{
    if (!_handler) {
        _handler = [[LCCalendarHandler alloc] init];
        _handler.cellIdentifier = _cellIdentifier;
    }
    return _handler;
}

@end

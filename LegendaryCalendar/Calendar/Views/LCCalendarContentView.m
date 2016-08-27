//
//  LCCalendarContentView.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarContentView.h"
#import "NSDate+LCCalendar.h"
#import "LCCalendarHandler.h"
#import "LCCalendarCell.h"
#import "LCCalendarModel.h"

static NSString * const _cellIdentifier = @"LCCalendarCell";

@interface LCCalendarContentView ()

@property (nonatomic, strong) UICollectionView      *collectionView;
@property (nonatomic, strong) LCCalendarHandler     *handler;
@end

@implementation LCCalendarContentView{
}

#pragma mark - public

- (void)loadWithMonthsToCurrrentMonth:(NSInteger )monthsToCurrrentMonth{
    [self updateDataWithMonths:monthsToCurrrentMonth];
}

#pragma mark - private methods
- (void)updateDataWithMonths:(NSInteger )months{
    WEAKSELF
    [self.handler updateDataWithMonthsToCurrrentMonth:months CompletionBlock:^(NSDate *date) {
        STRONGSELF
        [strongSelf.handler setCurrentDate:date];
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
    [self addSubview:self.collectionView];
    
    [self loadWithMonthsToCurrrentMonth:0];
}

#pragma mark - layout
- (void)layoutSubviews{
    self.collectionView.frame = self.bounds;
}
#pragma mark - getter
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

//
//  LCRootViewController.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/10.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCRootViewController.h"
#import "LCCalendarCell.h"
#import "LCCalendarCellModel.h"
#import "NSDate+LCCalendar.h"

@interface LCRootViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView    *calendarView;
@property (nonatomic, strong) NSMutableArray      *allDates;
@end

@implementation LCRootViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
//    self.allDates = [NSMutableArray array];
//    [self.allDates addObjectsFromArray:[[NSDate date] lc_preMonthDates]];
//    [self.allDates addObjectsFromArray:[[NSDate date] lc_currentDates]];
//    [self.allDates addObjectsFromArray:[[NSDate date] lc_nextMonthDates]];
//    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    _calendarView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
//    _calendarView.delegate = self;
//    _calendarView.dataSource = self;
//    [_calendarView registerClass:[LCCalendarCell class] forCellWithReuseIdentifier:@"calendarCell"];
//    _calendarView.backgroundColor = [UIColor whiteColor];
//    
//    [self.view addSubview:_calendarView];
}

#pragma mark - ui collection view datasource



@end

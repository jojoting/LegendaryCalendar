//
//  LCCalendarViewController.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

//controllers
#import "LCCalendarViewController.h"

//views
#import "LCCalendarView.h"
#import "LCActionPicker.h"
#import "LCMemoContentView.h"

#import "LCMemoContentCellModel.h"
#import "LCMemoContentCell.h"

//others
#import "LCMemoService.h"
#import "LCMemoModel.h"
#import "LCMemoCellLayout.h"

//vendor

#define CALENDAR_H   ((SCREEN_H - 20) * 0.6)

static NSMutableArray  *availableYears;
static NSMutableArray  *availableMonths;

const NSUInteger    availableStartYear = 1900;
const NSUInteger    availableEndYear = 2100;

static NSString * const contentCellIdentifier = @"contentCell";

@interface LCCalendarViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate> {
}

@property (nonatomic, strong) LCCalendarView    *calendarView;
@property (nonatomic, strong) LCMemoContentView *contentView;


@end

@implementation LCCalendarViewController {
    NSArray<LCMemoModel *>                      *_memoModels;
    NSMutableArray<LCMemoCellLayout *>          *_cellLayouts;
    NSMutableArray<LCMemoContentCellModel *>    *_cellModels;
    
    NSInteger _debug;
}

#pragma mark - life cycle
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _memoModels = [NSArray array];
    _cellModels = [NSMutableArray array];
    _cellLayouts = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.calendarView];
    [self.view addSubview:self.contentView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectMonthAndYear:) name:LCCalendarSelectMonthAndYearNotify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectDate:) name:LCCalendarSelectDateNotify object:nil];
    
    if ([LCMemoService modelsWithDate:[NSDate date]].count == 0) {
        LCMemoModel *model = [[LCMemoModel alloc] init];
        model.memoName = @"测试测试标题";
        model.memoDetail = @"测试测试测试测试副标题";
        model.memoLevel = LCMemoLevelHigh;
        model.memoDescribe = @"测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述";
        [LCMemoService writeModel:model toFileWithDate:[NSDate date]];
        [LCMemoService writeModel:model toFileWithDate:[NSDate date]];
        [LCMemoService writeModel:model toFileWithDate:[NSDate date]];
        [LCMemoService writeModel:model toFileWithDate:[NSDate date]];
        
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.calendarView selectDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)configCell:(LCMemoContentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    LCMemoContentCellModel *cellModel = _cellModels[indexPath.row];
    LCMemoCellLayout *layout = _cellLayouts[indexPath.row];
    [cell configCellWithCellModel:cellModel layout:layout];
}

- (void)showActionPickerWithDatas:(NSArray *)datas {
    WEAKSELF
    LCActionPicker *actionPicker = [LCActionPicker actionPickerWithTitle:@"选择年月" datas:@[availableYears,availableMonths] comfirmBlock:^(LCActionPicker *picker, NSArray *values) {
        [picker dismiss:YES];
        [weakSelf.calendarView loadMonth:[values[1] integerValue] year:[values[0] integerValue] animated:YES];
    } cancelBlock:^(LCActionPicker *picker) {
        [picker dismiss:YES];
    }];
    [actionPicker show:YES];
    [actionPicker setCurrentData:datas];

}
#pragma mark - notify method
- (void)didSelectMonthAndYear:(NSNotification *)notify{
    if (!availableYears) {
        availableYears = [NSMutableArray array];
        for (NSInteger i = availableStartYear; i <= availableEndYear; i ++) {
            [availableYears addObject:@(i)];
        }
    }
    if (!availableMonths) {
        availableMonths = [NSMutableArray array];
        for (NSInteger i = 1; i <= 12; i ++) {
            [availableMonths addObject:@(i)];
        }
    }
    NSArray *datas = @[
                      notify.userInfo[LCCalendarSelectMonthAndYearNotifyInfoYear],
                      notify.userInfo[LCCalendarSelectMonthAndYearNotifyInfoMonth]
                      ];
    [self showActionPickerWithDatas:datas];
}

- (void)didSelectDate:(NSNotification *)notify{
    NSDate *date = (NSDate *)notify.userInfo[LCCalendarSelectDateNotifyInfoDate];
    
    _memoModels = [LCMemoService modelsWithDate:date];
    for (LCMemoModel *model in _memoModels) {
        LCMemoContentCellModel *cellModel = [LCMemoContentCellModel cellModelWithModel:model];
        [_cellModels addObject:cellModel];
        [_cellLayouts addObject:[LCMemoCellLayout creatLayoutWithCellModel:cellModel]];
    }
    
    [self.contentView reloadData];
#if DEBUG
    NSLog(@"select date:%@",date);
    NSLog(@"select memos:%@",_memoModels);
#endif
    
}

#pragma mark - UITabelView delegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellLayouts.count > 0) {
        return _cellLayouts[indexPath.row].cellHeight;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
#pragma mark - UITableView datasource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _memoModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCMemoContentCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCellIdentifier];
    if (cell == nil) {
        cell = [[LCMemoContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentCellIdentifier];
    }
    [self configCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - getter
- (LCCalendarView *)calendarView{
    if (!_calendarView) {
        _calendarView = [[LCCalendarView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_W, CALENDAR_H)];
        //    _calendarView.delegate = self;
    }
    return _calendarView;
}

- (LCMemoContentView *)contentView {
    if (!_contentView) {
        _contentView = [[LCMemoContentView alloc] initWithFrame:CGRectMake(0, CALENDAR_H + 20, SCREEN_W, SCREEN_H - CALENDAR_H - 20)];
        [_contentView registerClass:[LCMemoContentCell class] forCellReuseIdentifier:contentCellIdentifier];
        _contentView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentView.scrollsToTop = NO;
        _contentView.bounces = NO;
        _contentView.dataSource = self;
        _contentView.delegate = self;
    }
    return _contentView;
}
@end

//
//  LCCalendarViewController.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarViewController.h"
#import "LCCalendarView.h"
#import "LCActionPicker.h"

#define CALENDAR_H   ((SCREEN_H - 20) * 0.6)

static NSMutableArray  *availableYears;
static NSMutableArray  *availableMonths;

const NSUInteger    availableStartYear = 1900;
const NSUInteger    availableEndYear = 2100;

@interface LCCalendarViewController () <UIScrollViewDelegate> {
}

@property (nonatomic, strong) LCCalendarView    *calendarView;

@end

@implementation LCCalendarViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.calendarView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectMonthAndYear:) name:LCCalendarSelectMonthAndYearNotify object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - private 
- (void)selectMonthAndYear:(NSNotification *)notify{
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
    NSArray *data = @[
                      notify.userInfo[LCCalendarSelectMonthAndYearNotifyInfoYear],
                      notify.userInfo[LCCalendarSelectMonthAndYearNotifyInfoMonth]
                      ];
    
    WEAKSELF
    LCActionPicker *actionPicker = [LCActionPicker actionPickerWithTitle:@"选择年月" datas:@[availableYears,availableMonths] comfirmBlock:^(LCActionPicker *picker, NSArray *values) {
        [picker dismiss:YES];
        [weakSelf.calendarView loadMonth:[values[1] integerValue] year:[values[0] integerValue] animated:YES];
    } cancelBlock:^(LCActionPicker *picker) {
        [picker dismiss:YES];
    }];
    [actionPicker show:YES];
    [actionPicker setCurrentData:data];
}
#pragma mark - getter
- (LCCalendarView *)calendarView{
    if (!_calendarView) {
        _calendarView = [[LCCalendarView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_W, CALENDAR_H)];
        //    _calendarView.delegate = self;
    }
    return _calendarView;
}


@end

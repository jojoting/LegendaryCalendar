//
//  LCCalendarViewController.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarViewController.h"
#import "LCCalendarView.h"

@interface LCCalendarViewController () <UIScrollViewDelegate> {
    LCCalendarView  *_calendarView;
}

@end

@implementation LCCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _calendarView = [[LCCalendarView alloc] initWithFrame:self.view.frame];
//    _calendarView.delegate = self;
    [self.view addSubview:_calendarView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  LCAppDelegate.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/10.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCAppDelegate.h"
#import "LCRootNavigationController.h"
#import "LCRootViewController.h"
#import "LCRootTabBarController.h"

#import "NSDate+LCCalendar.h"

@interface LCAppDelegate () 

@end

@implementation LCAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application{
    
    
    LCRootViewController *rootViewController = [[LCRootViewController alloc] init];
    LCRootNavigationController *rootNavigationController = [[LCRootNavigationController alloc] initWithRootViewController:rootViewController];
    LCRootTabBarController *rootTabBarController = [[LCRootTabBarController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = rootNavigationController;
    [self.window makeKeyAndVisible];
    
    NSLog(@"days:%ld",[[NSDate date] lc_day]);
    NSLog(@"days of month:%ld",[[NSDate date] lc_daysOfMonth]);
    NSLog(@"weekday:%ld",[[NSDate date] lc_weekDay]);
    NSLog(@"chinese day:%@,",[[NSDate date] lc_chineseDay]);
    NSDate *date = [[NSDate date] lc_firstDayOfMonth];
    NSLog(@"first day of month:%@",date);
    NSLog(@"last day of month:%@",[[NSDate date] lc_lastDayOfMonth]);

}


@end

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
#import "LCCalendarViewController.h"
#import "NSDate+LCCalendar.h"

#import "LCPlistWrapper.h"
#import "LCMemoModel.h"
#import "LCMemoService.h"

@interface LCAppDelegate () 

@end

@implementation LCAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application{
    
    
    LCRootViewController *rootViewController = [[LCRootViewController alloc] init];
    LCRootNavigationController *rootNavigationController = [[LCRootNavigationController alloc] initWithRootViewController:rootViewController];
    LCRootTabBarController *rootTabBarController = [[LCRootTabBarController alloc] init];
    
    LCCalendarViewController *calendarViewController = [[LCCalendarViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = calendarViewController;
    [self.window makeKeyAndVisible];
    


}


@end

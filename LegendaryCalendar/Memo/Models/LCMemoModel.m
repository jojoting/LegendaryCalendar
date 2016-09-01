//
//  LCMemoModel.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/30.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCMemoModel.h"
#import "LCPlistWrapper.h"
#import <objc/runtime.h>

@implementation LCMemoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.memoName = @"";
        self.memoLevel = LCMemoLevelNormal;
        self.memoDetail = @"";
        self.memoDescribe = @"";
    }
    return self;
}


@end

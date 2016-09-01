//
//  LCMemoService.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/30.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCMemoModel;

@interface LCMemoService : NSObject

+ (NSArray<LCMemoModel *> *)modelsWithDate:(NSDate *)date;
+ (BOOL )writeModel:(LCMemoModel *)model toFileWithDate:(NSDate *)date;

@end

//
//  LCMemoService.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/30.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCMemoService.h"
#import "LCMemoModel.h"
#import "LCPlistWrapper.h"

static NSString * const PlistFileName = @"memo.plist";

static NSString * timeStampWithDate(NSDate *date) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

@implementation LCMemoService

+ (NSArray<LCMemoModel *> *)modelsWithDate:(NSDate *)date{
    NSDictionary *dic = (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:[LCPlistWrapper retrieveDataWithPlistFile:PlistFileName]];
    NSArray *values = dic[timeStampWithDate(date)];

    NSMutableArray  *models = [NSMutableArray array];
    for (NSDictionary *valueDic in values) {
        LCMemoModel *model = [[LCMemoModel alloc] init];
        model.memoName = valueDic[NSStringFromSelector(@selector(memoName))];
        model.memoDetail = valueDic[NSStringFromSelector(@selector(memoDetail))];
        model.memoDescribe = valueDic[NSStringFromSelector(@selector(memoDescribe))];
        model.memoLevel = [valueDic[NSStringFromSelector(@selector(memoLevel))] integerValue];
        [models addObject:model];
    }
    return [models copy];
}

+ (BOOL )writeModel:(LCMemoModel *)model toFileWithDate:(NSDate *)date{
    NSMutableDictionary *dic = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:[LCPlistWrapper retrieveDataWithPlistFile:PlistFileName]];
    NSMutableArray *values = [dic[timeStampWithDate(date)] mutableCopy];

    if (nil == dic) {
        dic = [NSMutableDictionary dictionary];
    }
    
    if (nil == values) {
        values = [NSMutableArray array];
    }
    NSDictionary *valueDic = @{
                          NSStringFromSelector(@selector(memoName)) : model.memoName,
                          NSStringFromSelector(@selector(memoDetail)) : model.memoDetail,
                          NSStringFromSelector(@selector(memoDescribe)) : model.memoDescribe,
                          NSStringFromSelector(@selector(memoLevel)) : @(model.memoLevel)
                          };
    [values addObject:valueDic];
    dic[timeStampWithDate(date)] = [values copy];
    return [LCPlistWrapper storeData:[NSKeyedArchiver archivedDataWithRootObject:dic] toPlistFile:PlistFileName];
}

@end

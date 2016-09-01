//
//  LCPlistWrapper.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/30.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCPlistWrapper.h"

@implementation LCPlistWrapper

+ (NSString *)filePathWithFileName:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths firstObject];
    return [path stringByAppendingPathComponent:fileName];
}

+ (BOOL)storeData:(NSData *)data toPlistFile:(NSString *)fileName{
    NSString *filePath = [self filePathWithFileName:fileName];
    return [data writeToFile:filePath atomically:YES];
}

+ (NSData *)retrieveDataWithPlistFile:(NSString *)fileName{
    NSString *filePath = [self filePathWithFileName:fileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

@end

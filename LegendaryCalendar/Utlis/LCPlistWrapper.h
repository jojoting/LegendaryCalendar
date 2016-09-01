//
//  LCPlistWrapper.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/30.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCPlistWrapper : NSObject

+ (NSString *)filePathWithFileName:(NSString *)fileName;
+ (BOOL)storeData:(NSData *)data toPlistFile:(NSString *)fileName;
+ (NSData *)retrieveDataWithPlistFile:(NSString *)filePath;

@end

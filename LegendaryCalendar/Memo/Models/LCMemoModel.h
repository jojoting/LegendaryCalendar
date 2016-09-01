//
//  LCMemoModel.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/30.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LCMemoLevel) {
    LCMemoLevelNormal = -1,
    LCMemoLevelLow,
    LCMemoLevelHigh
};

@interface LCMemoModel : NSObject

@property (nonatomic, copy) NSString    *memoName;
@property (nonatomic, copy) NSString    *memoDetail;
@property (nonatomic, copy) NSString    *memoDescribe;
@property (nonatomic, assign) LCMemoLevel   memoLevel;


@end

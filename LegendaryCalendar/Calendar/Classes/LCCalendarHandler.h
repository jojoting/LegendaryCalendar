//
//  LCCalendarHandler.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LCCalendarCellModel;
@class LCCalendarModel;

typedef NS_ENUM(NSInteger, LCCalendarUpdateType) {
    LCCalendarUpdateTypeCurrentMonth = -1,
    LCCalendarUpdateTypePreMonth = 0,
    LCCalendarUpdateTypeNextMonth
};
typedef void(^LCUpdateCompletionBlock)(LCCalendarModel *model);

@interface LCCalendarHandler : NSObject <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) NSString                    *cellIdentifier;

- (void)updateDataWithType:(LCCalendarUpdateType )type CompletionBlock:(LCUpdateCompletionBlock )block;

@end

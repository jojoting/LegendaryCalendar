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

typedef void(^LCUpdateCompletionBlock)(NSDate *date);

@interface LCCalendarHandler : NSObject <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) NSString                    *cellIdentifier;
@property (nonatomic, strong)NSMutableArray<NSDate *>   *allDates;

- (void)updateDataWithMonthsToCurrrentMonth:(NSInteger )monthsToCurrrentMonth CompletionBlock:(LCUpdateCompletionBlock )block;

@end

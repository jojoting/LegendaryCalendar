//
//  LCMemoContentCellModel.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/9/1.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCMemoModel;
@interface LCMemoContentCellModel : NSObject

@property (nonatomic, copy) NSAttributedString  *titleString;
@property (nonatomic, copy) NSAttributedString  *detailString;
@property (nonatomic, copy) NSAttributedString  *levelString;
@property (nonatomic, copy) NSAttributedString  *describeString;

+ (instancetype)cellModelWithModel:(LCMemoModel *)model;

@end

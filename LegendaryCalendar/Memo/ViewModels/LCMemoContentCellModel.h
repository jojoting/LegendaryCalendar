//
//  LCMemoContentCellModel.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/9/1.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LCMemoModel;
@interface LCMemoContentCellModel : NSObject

@property (nonatomic, copy) NSMutableAttributedString  *titleString;
@property (nonatomic, copy) NSMutableAttributedString  *detailString;
@property (nonatomic, copy) NSMutableAttributedString  *levelString;
@property (nonatomic, copy) NSMutableAttributedString  *describeString;

+ (instancetype)cellModelWithModel:(LCMemoModel *)model;

@end

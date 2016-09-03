//
//  LCMemoCellLayout.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/9/3.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LCMemoContentCellModel;

@interface LCMemoCellLayout : NSObject

@property (nonatomic, assign) CGFloat titleLabelHeight;
@property (nonatomic, assign) CGFloat detailLabelHeight;
@property (nonatomic, assign) CGFloat levelLabelHeight;
@property (nonatomic, assign) CGFloat describeLabelHeight;
@property (nonatomic, assign) CGFloat labelWidth;
@property (nonatomic, assign) CGFloat labelMargin;

@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)creatLayoutWithCellModel:(LCMemoContentCellModel *)cellModel;
- (void)layoutWithCellModel:(LCMemoContentCellModel *)cellModel;

@end

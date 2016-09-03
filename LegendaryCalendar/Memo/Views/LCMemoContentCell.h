//
//  LCMemoContentCell.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/9/3.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCMemoContentCellModel;
@class LCMemoCellLayout;

@interface LCMemoContentCell : UITableViewCell

@property (nonatomic, strong) UILabel *memoTitleLabel;
@property (nonatomic, strong) UILabel *memoDetailLabel;
@property (nonatomic, strong) UILabel *memoLevelLabel;
@property (nonatomic, strong) UILabel *memoDescribeLabel;

- (void)configCellWithCellModel:(LCMemoContentCellModel *)cellModel layout:(LCMemoCellLayout *)layout;

@end

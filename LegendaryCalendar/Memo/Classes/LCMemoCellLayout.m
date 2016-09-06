//
//  LCMemoCellLayout.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/9/3.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCMemoCellLayout.h"
#import "LCMemoContentCellModel.h"

@implementation LCMemoCellLayout

+ (instancetype)creatLayoutWithCellModel:(LCMemoContentCellModel *)cellModel {
    return [[self alloc] initWithCellModel:cellModel];
}

- (instancetype)initWithCellModel:(LCMemoContentCellModel *)cellModel {
    if (self = [super init]) {
        [self layoutWithCellModel:cellModel];
    }
    return self;
}

- (void)layoutWithCellModel:(LCMemoContentCellModel *)cellModel {
    _labelWidth = SCREEN_W - 40;
    _labelMargin = 10;
    _labelLeftMargin = 20;
    
    _titleLabelHeight = [self labelHeightWithAttributedString:cellModel.titleString];
    _detailLabelHeight = [self labelHeightWithAttributedString:cellModel.detailString];
    _levelLabelHeight = [self labelHeightWithAttributedString:cellModel.levelString];
    _describeLabelHeight = [self labelHeightWithAttributedString:cellModel.describeString];
    
    _cellHeight = _labelMargin * 4 + _titleLabelHeight + _detailLabelHeight + _levelLabelHeight + _describeLabelHeight;
}

- (CGFloat )labelHeightWithAttributedString:(NSAttributedString *)attrString {
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attrString boundingRectWithSize:CGSizeMake(_labelWidth, CGFLOAT_MAX)
                                           options:options
                                           context:nil];
    return rect.size.height;
}

@end

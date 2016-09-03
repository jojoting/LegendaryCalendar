//
//  LCMemoContentCell.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/9/3.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCMemoContentCell.h"
#import "LCMemoContentCellModel.h"
#import "LCMemoCellLayout.h"

@implementation LCMemoContentCell {
    LCMemoContentCellModel  *_cellModel;
    LCMemoCellLayout    *_layout;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self.contentView addSubview:self.memoTitleLabel];
    [self.contentView addSubview:self.memoDetailLabel];
    [self.contentView addSubview:self.memoLevelLabel];
    [self.contentView addSubview:self.memoDescribeLabel];
}

#pragma mark - public
- (void)configCellWithCellModel:(LCMemoContentCellModel *)cellModel layout:(LCMemoCellLayout *)layout{
    _cellModel = cellModel;
    _layout = layout;
    
    self.memoTitleLabel.attributedText = cellModel.titleString;
    self.memoDetailLabel.attributedText = cellModel.detailString;
    self.memoLevelLabel.attributedText = cellModel.levelString;
    self.memoDescribeLabel.attributedText = cellModel.describeString;
    
    [self layoutIfNeeded];
}

#pragma mark - private
- (void)layoutSubviews{
    CGFloat labelWidth = _layout.labelWidth;
    
    self.memoTitleLabel.frame = CGRectMake(0, 0, labelWidth, _layout.titleLabelHeight);
    self.memoDetailLabel.frame = CGRectMake(0, self.memoTitleLabel.frame.size.height + _layout.labelMargin, labelWidth, _layout.detailLabelHeight);
    self.memoLevelLabel.frame = CGRectMake(0, self.memoTitleLabel.frame.size.height + self.memoDetailLabel.frame.size.height + _layout.labelMargin * 2, labelWidth, _layout.levelLabelHeight);
    self.memoDescribeLabel.frame = CGRectMake(0, self.memoTitleLabel.frame.size.height + self.memoDetailLabel.frame.size.height + self.memoLevelLabel.frame.size.height + _layout.labelMargin * 3, labelWidth, _layout.describeLabelHeight);
    
}

- (UILabel *)creatLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;

    return label;
}
#pragma mark - lazy
- (UILabel *)memoTitleLabel {
    if (!_memoTitleLabel) {
        _memoTitleLabel = [self creatLabel];
    }
    return _memoTitleLabel;
}

- (UILabel *)memoDetailLabel {
    if (!_memoDetailLabel) {
        _memoDetailLabel = [self creatLabel];
    }
    return _memoDetailLabel;
}

- (UILabel *)memoLevelLabel {
    if (!_memoLevelLabel) {
        _memoLevelLabel = [self creatLabel];
    }
    return _memoLevelLabel;
}

- (UILabel *)memoDescribeLabel {
    if (!_memoDescribeLabel) {
        _memoDescribeLabel = [self creatLabel];
    }
    return _memoDescribeLabel;
}
@end

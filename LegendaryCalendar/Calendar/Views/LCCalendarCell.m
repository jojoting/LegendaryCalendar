//
//  LCCalendarCell.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/11.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarCell.h"
#import "LCCalendarCellModel.h"

@interface LCCalendarCell (){
    LCCalendarCellModel *_cellModel;
}

@property (nonatomic, strong) UIView    *bgView;
@property (nonatomic, strong) UILabel   *dayLabel;
@property (nonatomic, strong) UILabel   *chineseDayLabel;

@end

@implementation LCCalendarCell {
    
}

#pragma mark - class methods

#pragma mark - public methods
- (void)setCellModel:(LCCalendarCellModel *)cellModel{
    _cellModel = cellModel;
    [self updateUI];
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.dayLabel];
    [self.bgView addSubview:self.chineseDayLabel];
}

#pragma mark - private methods

- (void)updateUI{
    self.bgView.backgroundColor = _cellModel.backgroundColor;
    self.dayLabel.attributedText = _cellModel.dateStr;
    self.chineseDayLabel.attributedText = _cellModel.chineseDateStr;

    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat contentViewHeight = self.contentView.frame.size.height;
    CGFloat contentViewWidth = self.contentView.frame.size.width;
    
    CGFloat bgViewHeight = self.contentView.frame.size.height * 0.64;
    CGFloat bgViewWidth = self.contentView.frame.size.width * 0.7;
    
    self.bgView.frame = CGRectMake((contentViewWidth - bgViewWidth) / 2, (contentViewHeight - bgViewHeight)/2, bgViewWidth, bgViewHeight);
    self.dayLabel.frame = CGRectMake(0, 0, bgViewWidth, bgViewHeight * 0.64);
    self.chineseDayLabel.frame = CGRectMake(0, self.dayLabel.frame.size.height, bgViewWidth, bgViewHeight - self.dayLabel.frame.size.height);
}

#pragma mark - getter

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
    }
    return _bgView;
}
- (UILabel *)dayLabel{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dayLabel;
}

- (UILabel *)chineseDayLabel{
    if (!_chineseDayLabel) {
        _chineseDayLabel = [[UILabel alloc] init];
    }
    return _chineseDayLabel;
}

#pragma mark - setter
- (void)setSelected:(BOOL)selected{
    [_cellModel setSelected:selected];
    [self updateUI];
}


@end

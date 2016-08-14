//
//  LCCalendarTitleView.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarTitleView.h"

@interface LCCalendarTitleView ()

@property (nonatomic, strong) UILabel   *titleLabel;

@end
@implementation LCCalendarTitleView

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    [self addSubview: self.titleLabel];
}

- (void)layoutSubviews{
    self.titleLabel.frame = self.frame;
}

- (void)updateWithYear:(NSUInteger )year month:(NSUInteger )month{
    self.titleLabel.text = [NSString stringWithFormat:@"%ld年%ld月",year,month];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.frame];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        _titleLabel.textColor = COLOR_HEX(0x2d2d2d, 1.0);
    }
    return _titleLabel;
}
@end

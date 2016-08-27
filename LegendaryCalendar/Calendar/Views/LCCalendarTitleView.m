//
//  LCCalendarTitleView.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/14.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCCalendarTitleView.h"

@interface LCCalendarTitleView ()

@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UIImageView   *iconView;

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
    [self addSubview:self.iconView];
}

- (void)layoutSubviews{
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width - 18, self.frame.size.height);
    self.iconView.frame = CGRectMake(self.titleLabel.frame.size.width, (self.frame.size.height - 18)/2, 18, 18);
}

- (void)updateWithYear:(NSUInteger )year month:(NSUInteger )month{
    self.year = year;
    self.month = month;
    self.titleLabel.text = [NSString stringWithFormat:@"%ld年%ld月",year,month];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        _titleLabel.textColor = COLOR_HEX(0x2d2d2d, 1.0);
    }
    return _titleLabel;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"pull_down"];
    }
    return _iconView;
}
@end

//
//  LCActionPickerToolBar.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/27.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCActionPickerToolBar.h"

@interface LCActionPickerToolBar ()

@property (nonatomic, strong) UIView    *divider;
@end
@implementation LCActionPickerToolBar

- (instancetype)init
{
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
    if (0 == self.buttonWidth) {
        self.buttonWidth = 60.f;
    }
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    [self addSubview:self.divider];
}

- (void)layoutSubviews{
    self.leftButton.frame = CGRectMake(0, 0, self.buttonWidth, self.frame.size.height);
    self.rightButton.frame = CGRectMake(self.frame.size.width - self.buttonWidth, 0, self.buttonWidth, self.frame.size.height);
    self.divider.frame = CGRectMake(10, self.frame.size.height - 1, self.frame.size.width - 20, 1);
}
#pragma mark - getter
- (UIView *)divider{
    if (!_divider) {
        _divider = [[UIView alloc] init];
        _divider.backgroundColor = COLOR_HEX(0xeeeeee, 1.f);
    }
    return _divider;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftButton.titleLabel.textAlignment = NSTextAlignmentRight;
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_rightButton setTitle:@"确定" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    }
    return _rightButton;
}
@end

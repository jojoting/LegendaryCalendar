//
//  LCMemoContentView.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/9/1.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCMemoContentView.h"

@interface LCMemoContentView ()

@end

@implementation LCMemoContentView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_HEX(0xeeeeee, 1.0);
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

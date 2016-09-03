//
//  LCMemoContentCellModel.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/9/1.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCMemoContentCellModel.h"
#import "LCMemoModel.h"

#define kLevelTextColor (_model.memoLevel == LCMemoLevelHigh ? COLOR_HEX(0xff0000, 1.0) : COLOR_HEX(0x000000, 1.0))
#define kTitleTitleAttr @{NSForegroundColorAttributeName : COLOR_HEX(0x999da0, 1.0), NSFontAttributeName : [UIFont systemFontOfSize:15.f]}
#define kTitleTextAttr @{NSForegroundColorAttributeName : COLOR_HEX(0x53a3ae, 1.0),NSFontAttributeName : [UIFont systemFontOfSize:15.f]}
#define kDetailTitleAttr @{NSForegroundColorAttributeName : COLOR_HEX(0x000000, 1.0),NSFontAttributeName : [UIFont boldSystemFontOfSize:12.f]}
#define kDetailTextAttr @{NSForegroundColorAttributeName : COLOR_HEX(0x000000, 1.0),NSFontAttributeName : [UIFont systemFontOfSize:10.f]}

#define kLevelTextAttr @{NSForegroundColorAttributeName : kLevelTextColor,NSFontAttributeName : [UIFont systemFontOfSize:10.f]}

@implementation LCMemoContentCellModel {
    LCMemoModel *_model;
}
+ (instancetype)cellModelWithModel:(LCMemoModel *)model {
    return [[self alloc] initWithModel:model];
}

- (instancetype)initWithModel:(LCMemoModel *)model {
    if (self = [super init]) {
        _model = model;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    if (_model == nil) {
        _model = [[LCMemoModel alloc] init];
    }
    [self.titleString addAttributes:kTitleTitleAttr range:NSMakeRange(0, 5)];
    [self.titleString addAttributes:kTitleTextAttr range:NSMakeRange(5, self.titleString.length - 5)];
    [self.detailString addAttributes:kDetailTitleAttr range:NSMakeRange(0, 5)];
    [self.detailString addAttributes:kDetailTextAttr range:NSMakeRange(5, self.detailString.length - 5)];
    [self.describeString addAttributes:kDetailTitleAttr range:NSMakeRange(0, 5)];
    [self.describeString addAttributes:kDetailTextAttr range:NSMakeRange(5, self.describeString.length - 5)];
    [self.levelString addAttributes:kDetailTitleAttr range:NSMakeRange(0, 4)];
    [self.levelString addAttributes:kLevelTextAttr range:NSMakeRange(4, self.levelString.length - 4)];
}

#pragma mark - getter
- (NSMutableAttributedString *)titleString {
    if (!_titleString) {
        _titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"项目名称：%@",_model.memoName]];
    }
    return _titleString;
}

- (NSMutableAttributedString *)detailString {
    if (!_detailString) {
        _detailString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"需求名称：%@",_model.memoName]];
    }
    return _detailString;
}

- (NSMutableAttributedString *)levelString {
    if (!_levelString) {
        NSString *level = @"";
        switch (_model.memoLevel) {
            case LCMemoLevelLow: {level = @"Low";}
                break;
            case LCMemoLevelNormal: {level = @"Normal";}
                break;
            case LCMemoLevelHigh: {level = @"High";}
                break;
            default:
                break;
        }
        _levelString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"优先级：%@",level]];
    }
    return _levelString;
}

- (NSMutableAttributedString *)describeString {
    if (!_describeString) {
        _describeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"需求描述：%@",_model.memoDescribe]];
    }
    return _describeString;
}
@end

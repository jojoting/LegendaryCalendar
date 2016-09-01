//
//  LCMemoContentCellModel.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/9/1.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCMemoContentCellModel.h"
#import "LCMemoModel.h"

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
    
    NSDictionary *titleAttr = @{
                                
                                };
}

#pragma mark - getter
- (NSAttributedString *)titleString {
    if (!_titleString) {
        _titleString = [[NSAttributedString alloc] initWithString:_model.memoName];
    }
    return _titleString;
}

- (NSAttributedString *)detailString {
    if (!_detailString) {
        _detailString = [[NSAttributedString alloc] initWithString:_model.memoDetail];
    }
    return _detailString;
}

- (NSAttributedString *)levelString {
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
        _levelString = [[NSAttributedString alloc] initWithString:level];
    }
    return _levelString;
}

- (NSAttributedString *)describeString {
    if (!_describeString) {
        _describeString = [[NSAttributedString alloc] initWithString:_model.memoDescribe];
    }
    return _describeString;
}
@end

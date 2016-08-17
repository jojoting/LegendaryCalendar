//
//  LCActionPicker.h
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/16.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCActionPicker;

typedef void(^LCActionPickerConfirmBlock)(LCActionPicker *picker, NSArray *values);
typedef void(^LCActionPickerCancelBlock)(LCActionPicker *picker);

@interface LCActionPicker : UIView

+ (instancetype)actionPickerWithTitle:(NSString *)title datas:(NSArray *)datas comfirmBlock:(LCActionPickerConfirmBlock )confirmBlock cancelBlock:(LCActionPickerCancelBlock )cancelBlock;

- (void)setCurrentData:(NSArray *)data;
- (void)show:(BOOL )animation;
- (void)dismiss:(BOOL )animation;
@end

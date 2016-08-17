//
//  LCActionPicker.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/16.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "LCActionPicker.h"

const CGFloat   kActionPickerToolBarHeight = 40;
const CGFloat   kActionPickerHeight = 220;
const CGFloat   kActionPickerAnimationDuration = 0.44;
const CGFloat   kActionPickerBackgroundViewAlpha = 0.4;

@interface LCActionPicker () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView  *picker;
@property (nonatomic, strong) UIToolbar     *toolBar;
@property (nonatomic, strong) UIView        *bgView;
@property (nonatomic, copy  ) LCActionPickerConfirmBlock    confirmBlock;
@property (nonatomic, copy  ) LCActionPickerCancelBlock     cancelBlock;


@end

@implementation LCActionPicker {
    NSString                     *_title;
    NSArray<NSArray *>           *_datas;
    NSMutableArray               *_values;

}

#pragma mark - class methods
+ (instancetype)actionPickerWithTitle:(NSString *)title datas:(NSArray<NSArray *> *)datas comfirmBlock:(LCActionPickerConfirmBlock )confirmBlock cancelBlock:(LCActionPickerCancelBlock )cancelBlock{
    return [[self alloc] initWithTitle:title datas:datas comfirmBlock:confirmBlock cancelBlock:cancelBlock];
}
#pragma mark - public method
- (void)show:(BOOL )animation{
    if (self.superview == nil) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.bgView];
        [window addSubview:self];
        self.bgView.frame = window.bounds;
    }
    if (animation) {
        [UIView animateWithDuration:kActionPickerAnimationDuration animations:^{
            self.bgView.alpha = kActionPickerBackgroundViewAlpha;
            self.frame = CGRectMake(0, SCREEN_H - kActionPickerHeight, SCREEN_W, kActionPickerHeight);
        }];
    } else {
        self.bgView.alpha = 0.4;
        self.frame = CGRectMake(0, SCREEN_H - kActionPickerHeight, SCREEN_W, kActionPickerHeight);
    }
}

- (void)dismiss:(BOOL )animation{
    if (animation){
        [UIView animateWithDuration:kActionPickerAnimationDuration animations:^{
            self.bgView.alpha = 0.f;
            self.frame = CGRectMake(0, SCREEN_H, SCREEN_W, kActionPickerToolBarHeight);
            
        } completion:^(BOOL finished) {
            [self.bgView removeFromSuperview];
            [self removeFromSuperview];
        }];
    }
    
    else{
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }

}

- (void)setCurrentData:(NSArray *)data{
    for (NSInteger i = 0; i < data.count; i++) {
        [self.picker selectRow:[_datas[i] indexOfObject:data[i]] inComponent:i animated:NO];
        _values[i] = data[i];
    }
}

#pragma mark - private methods
- (void)cancelAction:(id)sender {
    if (_cancelBlock) {
        _cancelBlock(self);
    }
}

- (void)confirmAction:(id)sender {
    if (_confirmBlock) {
        _confirmBlock(self, _values);
    }
}
#pragma mark - init
- (instancetype)initWithTitle:(NSString *)title datas:(NSArray<NSArray *> *)datas comfirmBlock:(LCActionPickerConfirmBlock )confirmBlock cancelBlock:(LCActionPickerCancelBlock )cancelBlock{
    self = [super initWithFrame:CGRectMake(0, SCREEN_H, SCREEN_W, kActionPickerHeight)];
    if (self) {
        _title = title;
        _datas = datas;
        _confirmBlock = confirmBlock;
        _cancelBlock = cancelBlock;
        
        [self initialize];
    }
    return self;
}

- (void)initialize{
    _values = [NSMutableArray array];
    for (NSInteger i = 0; i < _datas.count; i ++) {
        [_values addObject:[NSNull null]];
    }
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.toolBar];
    [self addSubview:self.picker];
}

- (void)layoutSubviews{
    self.toolBar.frame = CGRectMake(0, 0, self.frame.size.width, kActionPickerToolBarHeight);
    self.picker.frame = CGRectMake(0, kActionPickerToolBarHeight, self.frame.size.width, kActionPickerHeight - kActionPickerToolBarHeight);
}
#pragma mark - UIPickerViewDatasource,UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return _datas.count;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _datas[component].count;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.frame.size.width / _datas.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%@",_datas[component][row]];
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _values[component] = _datas[component][row];
}

#pragma mark - getter

- (UIToolbar *)toolBar{
    if (!_toolBar) {
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)];
        leftBarButton.tintColor = MAIN_COLOR;
        
        
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(confirmAction:)];
        rightBarButton.tintColor = MAIN_COLOR;
        
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *fixedSpaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        fixedSpaceItem.width = 10;
        
        _toolBar = [[UIToolbar alloc]initWithFrame:CGRectZero];
        _toolBar.backgroundColor = [UIColor whiteColor];
        [_toolBar setItems:@[fixedSpaceItem,leftBarButton,spaceItem,rightBarButton,fixedSpaceItem] animated:YES];
    }
    return _toolBar;
}

- (UIPickerView *)picker{
    if (!_picker) {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _picker.showsSelectionIndicator=YES;
        _picker.dataSource = self;
        _picker.delegate = self;
    }
    return _picker;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0;

    }
    return _bgView;
}




@end

//
//  YLTimePicker.m
//  YLFunction
//
//  Created by lm on 2019/1/21.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLTimePicker.h"
#import "YLCondition.h"

#define YLPICKERHEIGHT 40
#define YLPICKERWIDTH self.frame.size.width / 4
#define YLScreenWidth [UIScreen mainScreen].bounds.size.width
#define YLScreenHeight [UIScreen mainScreen].bounds.size.height
#define YLLeftMargin 15

@interface YLTimePicker () <UIPickerViewDelegate , UIPickerViewDataSource> {
    NSString *selectHour;
    NSString *selectMinute;
}

@property (nonatomic, strong) NSMutableArray *hours;
@property (nonatomic, strong) NSMutableArray *minutes;
@property (nonatomic, strong) UIPickerView *hourPicker;
@property (nonatomic, strong) UIPickerView *minutePicker;

@end

@implementation YLTimePicker

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CGFloat height = 85;
    CGFloat pickW = 60;
    CGFloat labelW = 30;
    CGFloat pickX = (YLScreenWidth - 2 * pickW - 2 * labelW) / 2 ;
    
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(pickX, 0, pickW, height)];
    picker.delegate = self;
    picker.dataSource = self;
    [self addSubview:picker];
    self.hourPicker = picker;
    [self.hourPicker selectRow:[self currentHour] inComponent:0 animated:YES];
    NSInteger row = [self currentHour];
    selectHour = self.hours[row];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picker.frame), 0, labelW, height)];
    label1.text = @"时";
    label1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label1];
    
    UIPickerView *picker1 = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 0, pickW, height)];
    picker1.delegate = self;
    picker1.dataSource = self;
    [self addSubview:picker1];
    self.minutePicker = picker1;
    [self.minutePicker selectRow:[self currentMinute] inComponent:0 animated:YES];
    NSInteger row1 = [self currentMinute];
    selectMinute = self.minutes[row1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picker1.frame), 0, labelW, height)];
    label2.text = @"分";
    label2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label2];
    
    CGFloat btnW = (YLScreenWidth - 2 * YLLeftMargin - 10) / 2;
    YLCondition *cancelBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(YLLeftMargin, height + YLLeftMargin, btnW, 40);
    cancelBtn.type = YLConditionTypeWhite;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    YLCondition *sureBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame) + 10, height + YLLeftMargin, btnW, 40);
    sureBtn.type = YLConditionTypeBlue;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    
}

- (void)cancelClick {
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)sureClick {
    NSString *time = [NSString stringWithFormat:@"%@:%@", selectHour, selectMinute];
    if (self.sureBlock) {
        self.sureBlock(time);
    }
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.hourPicker) {
        return self.hours.count;
    } else {
        return self.minutes.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return YLPICKERHEIGHT;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YLPICKERWIDTH, YLPICKERHEIGHT)];
    title.textAlignment = NSTextAlignmentCenter;
    if (pickerView == self.hourPicker) {
        title.text = self.hours[row];
    }  else {
        title.text = self.minutes[row];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.hourPicker) {
        NSInteger hourRow = [self.hourPicker selectedRowInComponent:0];
        selectHour = self.hours[hourRow];
    } else {
        NSInteger minuteRow = [self.minutePicker selectedRowInComponent:0];
        selectMinute = self.minutes[minuteRow];
    }
    
}

- (NSInteger)currentHour {
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = kCFCalendarUnitHour;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nowDate];
    return [dateComponent hour];
}

- (NSInteger)currentMinute {
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = kCFCalendarUnitMinute;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nowDate];
    return [dateComponent minute];
}

- (NSMutableArray *)hours {
    if (!_hours) {
        _hours = [NSMutableArray array];
        for (NSInteger i = 0; i < 24; i++) {
            if (i < 10) {
                [_hours addObject:[NSString stringWithFormat:@"0%ld", i]];
            } else {
                [_hours addObject:[NSString stringWithFormat:@"%ld", i]];
            }
        }
//        [self.hourPicker selectRow:[self currentHour] inComponent:0 animated:YES];
    }
    
    return _hours;
}

- (NSMutableArray *)minutes {
    if (!_minutes) {
        _minutes = [NSMutableArray array];
        for (NSInteger i = 0; i < 60; i++) {
            if (i < 10) {
                [_minutes addObject:[NSString stringWithFormat:@"0%ld", i]];
            } else {
                [_minutes addObject:[NSString stringWithFormat:@"%ld", i]];
            }
        }
//        [self.minutePicker selectRow:[self currentMinute] inComponent:0 animated:YES];
    }
    return _minutes;
}

@end

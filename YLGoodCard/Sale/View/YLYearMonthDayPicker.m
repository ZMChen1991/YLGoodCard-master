//
//  YLYearMonthDayPicker.m
//  YLFunction
//
//  Created by lm on 2019/1/21.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLYearMonthDayPicker.h"

#import "YLCondition.h"

#define YLPICKERHEIGHT 40
#define YLPICKERWIDTH self.frame.size.width / 4
#define YLScreenWidth [UIScreen mainScreen].bounds.size.width
#define YLScreenHeight [UIScreen mainScreen].bounds.size.height
#define YLLeftMargin 15

@interface YLYearMonthDayPicker () <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    NSString *selectYear;
    NSString *selectMonth;
    NSString *selectDay;
}

@property (nonatomic, strong) UIPickerView *yearPicker;
@property (nonatomic, strong) UIPickerView *monthPicker;
@property (nonatomic, strong) UIPickerView *dayPicker;

@property (nonatomic, strong) NSMutableArray *years;
@property (nonatomic, strong) NSMutableArray *months;
@property (nonatomic, strong) NSMutableArray *days;

@end

@implementation YLYearMonthDayPicker

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
    CGFloat pickX = (YLScreenWidth - 2 * pickW - 3 * labelW) / 3 ;
    
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(pickX, 0, pickW, height)];
    picker.delegate = self;
    picker.dataSource = self;
    [self addSubview:picker];
    self.yearPicker = picker;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picker.frame), 0, labelW, height)];
    label1.text = @"年";
    label1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label1];
    
    UIPickerView *picker1 = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 0, pickW, height)];
    picker1.delegate = self;
    picker1.dataSource = self;
    [self addSubview:picker1];
    self.monthPicker = picker1;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picker1.frame), 0, labelW, height)];
    label2.text = @"月";
    label2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label2];
    
    UIPickerView *picker3 = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), 0, pickW, height)];
    picker3.delegate = self;
    picker3.dataSource = self;
    [self addSubview:picker3];
    self.dayPicker = picker3;
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picker3.frame), 0, labelW, height)];
    label3.text = @"日";
    label3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label3];
    
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
    
    NSString *time = [NSString stringWithFormat:@"%@-%@-%@", selectYear, selectMonth, selectDay];
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
    if (pickerView == self.yearPicker) {
        return self.years.count;
    } else if (pickerView == self.monthPicker) {
        return self.months.count;
    } else {
        return self.days.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return YLPICKERHEIGHT;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YLPICKERWIDTH, YLPICKERHEIGHT)];
    title.textAlignment = NSTextAlignmentCenter;
    if (pickerView == self.yearPicker) {
        title.text = self.years[row];
    } else if (pickerView == self.monthPicker) {
        title.text = self.months[row];
    } else {
        title.text = self.days[row];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.yearPicker == pickerView) {
        selectYear = [self.years objectAtIndex:row];
        // 选中年份，刷新月份
        [self restMonthsWtithYear:[selectYear integerValue]];
        [self.monthPicker reloadAllComponents];
        NSInteger monthRow = [self.monthPicker selectedRowInComponent:component];
        selectMonth = self.months[monthRow];
        [self restDaysWithYear:[selectYear integerValue] month:[selectMonth integerValue]];
        [self.dayPicker reloadAllComponents];
        NSInteger dayRow = [self.dayPicker selectedRowInComponent:component];
        selectDay = self.days[dayRow];
        
    } else if (self.monthPicker == pickerView) {
        selectMonth = [self.months objectAtIndex:row];
        [self restDaysWithYear:[selectYear integerValue] month:[selectMonth integerValue]];
        [self.dayPicker reloadAllComponents];
        NSInteger dayRow = [self.dayPicker selectedRowInComponent:component];
        selectDay = self.days[dayRow];
        
    } else {
        NSInteger dayRow = [self.dayPicker selectedRowInComponent:component];
        selectDay = self.days[dayRow];
    }
}

#pragma mark 重置月份
- (void)restMonthsWtithYear:(NSInteger)year {
    NSInteger totalMonth = 1;
    [self.months removeAllObjects];
    if ([self currentYear] == year) {
        totalMonth = [self currentMonth];
        for (NSInteger i = totalMonth; i < 13; i++) {
            [self.months addObject:[NSString stringWithFormat:@"%ld", i]];
        }
    } else {
        for (NSInteger i = 1; i < 13; i++) {
            [self.months addObject:[NSString stringWithFormat:@"%ld", i]];
        }
    }
}

#pragma mark 重置天数
- (void)restDaysWithYear:(NSInteger)year month:(NSInteger)month   {
    // 若年份和月份都是今年本月，天数显示剩下的天数
    NSInteger totalDay = 0;
    [self.days removeAllObjects];
    if (year == [self currentYear] && month == [self currentMonth]) {
        totalDay = [self currentDay];
        NSInteger days = [self daysWithYear:year month:month];
        for (NSInteger i = totalDay; i < days + 1; i++) {
            [self.days addObject:[NSString stringWithFormat:@"%ld", i]];
        }
    } else {
        NSInteger days = [self daysWithYear:year month:month];
        for (NSInteger i = 1; i < days + 1; i++) {
            [self.days addObject:[NSString stringWithFormat:@"%ld", i]];
        }
    }
}

#pragma mark 获取某年某月的天数
- (NSInteger)daysWithYear:(NSInteger)year month:(NSInteger)month {
    
    NSInteger totalDay = 0;
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
        totalDay = 31;
    } else if(month == 2) {
        if (((year % 4 == 0 && year % 100 != 0 ))|| (year % 400 == 0)) {
            totalDay = 29;
        } else {
            totalDay = 28;
        }
    } else {
        totalDay = 30;
    }
    return totalDay;
}

// 当前年份
- (NSInteger)currentYear {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY"];
    return [[dateFormatter stringFromDate:[NSDate date]] integerValue];
}
- (NSInteger)currentMonth {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    return [[dateFormatter stringFromDate:[NSDate date]] integerValue];
}

- (NSInteger)currentDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    return [[dateFormatter stringFromDate:[NSDate date]] integerValue];
}

- (NSMutableArray *)years {
    if (!_years) {
        _years = [NSMutableArray array];
        NSInteger totalYear = [self currentYear];
        for (NSInteger i = totalYear; i < totalYear + 50; i++) {
            [_years addObject:[NSString stringWithFormat:@"%ld", i]];
        }
        selectYear = [NSString stringWithFormat:@"%ld", [self currentYear]];
    }
    return _years;
}

- (NSMutableArray *)months {
    if (!_months) {
        _months = [NSMutableArray array];
        NSInteger totalMonth = [self currentMonth];
        for (NSInteger i = totalMonth; i < 13; i++) {
            [_months addObject:[NSString stringWithFormat:@"%ld", i]];
        }
        selectMonth = [NSString stringWithFormat:@"%ld", [self currentMonth]];
    }
    return _months;
}

- (NSMutableArray *)days {
    if (!_days) {
        _days = [NSMutableArray array];
        NSInteger totalDay = [self currentDay];
        NSInteger days = [self daysWithYear:[self currentYear] month:[self currentMonth]];
        for (NSInteger i = totalDay; i < days + 1; i++) {
            [_days addObject:[NSString stringWithFormat:@"%ld", i]];
        }
        selectDay = [NSString stringWithFormat:@"%ld", [self currentDay]];
    }
    return _days;
}

@end

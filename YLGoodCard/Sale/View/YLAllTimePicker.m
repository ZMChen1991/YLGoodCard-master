//
//  YLAllTimePicker.m
//  YLGoodCard
//
//  Created by lm on 2018/12/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLAllTimePicker.h"
#import "YLCondition.h"

#define YLPICKERHEIGHT 40
#define YLPICKERWIDTH self.frame.size.width * 0.6 / 5
#define YLLABELWIDTH self.frame.size.width * 0.4 / 5

@interface YLAllTimePicker ()<UIPickerViewDelegate, UIPickerViewDataSource> {
    
    NSInteger selectYearRow;
    NSInteger selectMonthRow;
    NSInteger selectDayRow;
    
    NSString *selectHour;
    NSString *selectMinute;
    
    NSInteger selectHourRow;
    NSInteger selectMinuteRow;
}

@property (nonatomic, strong) UIPickerView *yearPickerView;
@property (nonatomic, strong) UIPickerView *monthPickerView;
@property (nonatomic, strong) UIPickerView *dayPickerView;
@property (nonatomic, strong) UIPickerView *hourPicker;
@property (nonatomic, strong) UIPickerView *minutePicker;

// 存放年月日数组
@property (nonatomic, strong) NSMutableArray *years;
@property (nonatomic, strong) NSMutableArray *months;
@property (nonatomic, strong) NSMutableArray *days;
@property (nonatomic, strong) NSMutableArray *hours;
@property (nonatomic, strong) NSMutableArray *minutes;

@property (nonatomic, assign) NSInteger selectYear;
@property (nonatomic, assign) NSInteger selectMonth;
@property (nonatomic, assign) NSInteger selectDay;

@end


@implementation YLAllTimePicker
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectYear = [[self.years objectAtIndex:0] integerValue];
        self.selectMonth = [[self.months objectAtIndex:0] integerValue];
        self.selectDay = [[self.days objectAtIndex:0] integerValue];
        selectHour = [self.hours objectAtIndex:0];
        selectMinute = [self.minutes objectAtIndex:0];
        
    }
    return self;
}

- (void)setupUI {
    
    CGFloat height = 200 - 40;
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, YLPICKERWIDTH, height)];
    picker.delegate = self;
    picker.dataSource = self;
    [self addSubview:picker];
    self.yearPickerView = picker;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picker.frame), 0, YLLABELWIDTH, height)];
    label1.text = @"年";
    label1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label1];
    
    UIPickerView *picker1 = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 0, YLPICKERWIDTH, height)];
    picker1.delegate = self;
    picker1.dataSource = self;
    [self addSubview:picker1];
    self.monthPickerView = picker1;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picker1.frame), 0, YLLABELWIDTH, height)];
    label2.text = @"月";
    label2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label2];
    
    UIPickerView *picker2 = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), 0, YLPICKERWIDTH, height)];
    picker2.delegate = self;
    picker2.dataSource = self;
    [self addSubview:picker2];
    self.dayPickerView = picker2;
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picker2.frame), 0, YLLABELWIDTH, height)];
    label3.text = @"日";
    label3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label3];
    
    UIPickerView *picker3 = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame), 0, YLPICKERWIDTH, height)];
    picker3.delegate = self;
    picker3.dataSource = self;
    [self addSubview:picker3];
    self.hourPicker = picker3;
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picker3.frame), 0, YLLABELWIDTH, height)];
    label4.text = @"时";
    label4.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label4];
    
    UIPickerView *picker4 = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label4.frame), 0, YLPICKERWIDTH, height)];
    picker4.delegate = self;
    picker4.dataSource = self;
    [self addSubview:picker4];
    self.minutePicker = picker4;
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picker4.frame), 0, YLLABELWIDTH, height)];
    label5.text = @"分";
    label5.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label5];
    
    CGFloat btnW = (YLScreenWidth - 2 * YLLeftMargin - 10) / 2;
    YLCondition *cancelBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(YLLeftMargin, height + YLLeftMargin, btnW, 40);
    cancelBtn.type = YLConditionTypeWhite;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    YLCondition *sureBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame) + 10, height + YLLeftMargin, btnW, 40);
    sureBtn.type = YLConditionTypeBlue;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
}

- (void)cancelClick {

    NSLog(@"点击取消按钮");
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}
//
- (void)sureClick {

    NSLog(@"点击确定按钮");
    NSString *time = [NSString stringWithFormat:@"%ld-%ld-%ld %@:%@", self.selectYear, self.selectMonth,self.selectDay, selectHour, selectMinute];
    if (self.sureBlock) {
        self.sureBlock(time);
    }
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView == self.yearPickerView) {
        return self.years.count;
    }  else if (pickerView == self.monthPickerView) {
        return self.months.count;
    } else if (pickerView == self.dayPickerView) {
        return self.days.count;
    } else if (pickerView == self.hourPicker) {
        return self.hours.count;
    } else {
        return self.minutes.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return YLPICKERWIDTH;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return YLPICKERHEIGHT;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YLPICKERWIDTH, YLPICKERHEIGHT)];
    title.textAlignment = NSTextAlignmentCenter;
    if (pickerView == self.yearPickerView) {
        title.text = self.years[row];
    }  else if (pickerView == self.monthPickerView) {
        title.text = self.months[row];
    } else if (pickerView == self.dayPickerView) {
        title.text = self.days[row];
    } else if (pickerView == self.hourPicker) {
        title.text = self.hours[row];
    } else {
        title.text = self.minutes[row];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.yearPickerView) {// 选择年份，刷新月份和天数
        selectYearRow = row;
        self.selectYear = [[self.years objectAtIndex:selectYearRow] integerValue];
        NSLog(@"selectYear:%ld", self.selectYear);
        [self restMonthsWtithYear:self.selectYear];
        [self.monthPickerView reloadAllComponents];
        [self.monthPickerView selectRow:0 inComponent:0 animated:YES];//刷新后月份重新开始
        
        selectMonthRow = 0; // 刷新后重置
        self.selectMonth = [[self.months objectAtIndex:selectMonthRow] integerValue];
        NSLog(@"selectMonth:%ld", self.selectMonth);
        [self restDaysWithYear:self.selectYear Month:self.selectMonth];
        [self.dayPickerView reloadAllComponents];
        [self.dayPickerView selectRow:0 inComponent:0 animated:YES];// 刷新后天数重新开始
        selectDayRow = 0;
        self.selectDay = [[self.days objectAtIndex:selectDayRow] integerValue];
        NSLog(@"%ld-%ld", self.selectYear, self.selectMonth);
        
    } if (pickerView == self.monthPickerView) {
        selectMonthRow = row;
        self.selectMonth = [[self.months objectAtIndex:selectMonthRow] integerValue];
        NSLog(@"选择年份e和月份:%ld-%ld", self.selectYear, self.selectMonth);
        [self restDaysWithYear:self.selectYear Month:self.selectMonth];
        [self.dayPickerView reloadAllComponents];
        [self.dayPickerView selectRow:0 inComponent:0 animated:YES];// 刷新后天数重新开始
        selectDayRow = 0;
        self.selectDay = [[self.days objectAtIndex:selectDayRow] integerValue];
    } if (pickerView == self.dayPickerView) {
        selectDayRow = row;
        self.selectDay = [[self.days objectAtIndex:selectDayRow] integerValue];
    } if (pickerView == self.hourPicker) {
        selectHourRow = row;
        selectHour = [self.hours objectAtIndex:selectHourRow];
    } if (pickerView == self.minutePicker) {
        selectMinuteRow = row;
        selectMinute = [self.minutes objectAtIndex:selectMinuteRow];
    }
    //    NSLog(@"当前选择的时间是%@:%@", selectHour, selectMinute);
    
    //    NSLog(@"%ld-%ld-%ld %@:%@", self.selectYear, self.selectMonth, self.selectDay ,selectHour, selectMinute);
//    NSString *timeString = [NSString stringWithFormat:@"%ld-%ld-%ld %@:%@", self.selectYear, self.selectMonth, self.selectDay ,selectHour, selectMinute];
//    NSLog(@"%@", timeString);
//    if (self.timePickerBlock) {
//        self.timePickerBlock(timeString);
//    }
}

#pragma mark 获取当前年月日
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
        for (NSInteger i = totalMonth; i < 13; i++) {
            [self.months addObject:[NSString stringWithFormat:@"%ld", i]];
        }
    }
}

#pragma mark 重置天数
- (void)restDaysWithYear:(NSInteger)year Month:(NSInteger)month {
    
    NSInteger totalDay = 1;
    [self.days removeAllObjects];
    NSInteger days = [self daysWithYear:year month:month];
    
    if (year == [self currentYear] && month == [self currentMonth]) {
        totalDay = [self currentDay];
        for (NSInteger i = totalDay; i < days + 1; i++) {
            [self.days addObject:[NSString stringWithFormat:@"%ld", i]];
        }
    } else {
        for (NSInteger i = totalDay; i < days + 1; i++) {
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


#pragma mark 懒加载初始化
- (NSMutableArray *)years {
    if (!_years) {
        _years = [NSMutableArray array];
        NSInteger totalYear = [self currentYear];
        for (NSInteger i = totalYear; i < totalYear + 10; i++) {
            [_years addObject:[NSString stringWithFormat:@"%ld", i]];
        }
//        self.selectYear = [[_years objectAtIndex:0] integerValue];
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
//        NSInteger index = [self currentMonth] - 1;
//        self.selectMonth = [[_months objectAtIndex:index] integerValue];
    }
    return _months;
}

- (NSMutableArray *)days {
    if (!_days) {
        _days = [NSMutableArray array];
        NSInteger totalYear = [self currentYear];
        NSInteger totalMonth = [self currentMonth];
        NSInteger totalDay = [self currentDay];
        NSInteger maxDay = [self daysWithYear:totalYear month:totalMonth];
        for (NSInteger i = totalDay; i < maxDay + 1; i++) {
            [_days addObject:[NSString stringWithFormat:@"%ld", i]];
        }
//        NSInteger index = [self currentDay]- 1;
//        self.selectDay = [[_days objectAtIndex:index] integerValue];
    }
    return _days;
}

- (NSMutableArray *)hours {
    if (!_hours) {
        _hours = [NSMutableArray array];
        for (NSInteger i = 0; i < 24; i++) {
            if (i < 10) {
                [_hours addObject:[NSString stringWithFormat:@"0%ld",i]];
            } else {
                [_hours addObject:[NSString stringWithFormat:@"%ld",i]];
            }
        }
//        selectHourRow = 0;
//        selectHour = [self.hours objectAtIndex:selectHourRow];
    }
    return _hours;
}

- (NSMutableArray *)minutes {
    if (!_minutes) {
        _minutes = [NSMutableArray array];
        for (NSInteger i = 0; i < 60; i++) {
            if (i < 10) {
                [_minutes addObject:[NSString stringWithFormat:@"0%ld",i]];
            } else {
                [_minutes addObject:[NSString stringWithFormat:@"%ld",i]];
            }
        }
//        selectMinuteRow = 0;
//        selectMinute = [self.minutes objectAtIndex:selectMinuteRow];
    }
    return _minutes;
}


@end

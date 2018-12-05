//
//  YLTimePickView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/9.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLTimePickView.h"


#define YLTOOLBAR_HEIGHT 30 //顶部工具栏高度。
#define YLTITLE_HEIGHT 30 //标题高度。
#define YLDURATION 0.3 //动画时长。
#define YLTITLE_LABEL_START_TAG 1 //从左往右第一个标题Label的Tag值。

@interface YLTimePickView () <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    UIPickerView *datePickerView;
    UIView *toolBar;
    
    // 数据源
    NSMutableArray<NSString *> *monthArray;
    NSMutableArray<NSString *> *dayArray;
    NSMutableArray<NSString *> *hourArray;
    NSMutableArray<NSString *> *minutehArray;
}

@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *hour;
@property (nonatomic, strong) NSString *minute;

@end

@implementation YLTimePickView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self __initDate];
        [self __initView];
        
    }
    return self;
}

- (void)__initView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 顶部工具栏
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, YLTOOLBAR_HEIGHT)];
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(0, 0, 50, YLTOOLBAR_HEIGHT);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *completion = [UIButton buttonWithType:UIButtonTypeCustom];
    completion.frame = CGRectMake(width - 50, 0, 50, YLTOOLBAR_HEIGHT);
    [completion setTitle:@"完成" forState:UIControlStateNormal];
    completion.titleLabel.font = [UIFont systemFontOfSize:14];
    [completion setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [completion addTarget:self action:@selector(completionBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [toolBar addSubview:cancel];
    [toolBar addSubview:completion];
    [self addSubview:toolBar];
    
    // 标题
    [self __initTitleView];
    
    // UIPickerView
    datePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, YLTOOLBAR_HEIGHT + YLTITLE_HEIGHT, width, height - YLTOOLBAR_HEIGHT - YLTITLE_HEIGHT)];
    datePickerView.backgroundColor = [UIColor whiteColor];
    datePickerView.showsSelectionIndicator = YES;
    datePickerView.delegate = self;
    datePickerView.dataSource = self;
    [datePickerView selectRow:0 inComponent:0 animated:YES];
    [self addSubview:datePickerView];
}

- (void)__initTitleView {
    
    NSArray *titleArray = @[@"月", @"日", @"时", @"分"];
    float titleW = self.frame.size.width / titleArray.count;
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * titleW, YLTOOLBAR_HEIGHT, titleW, YLTITLE_HEIGHT)];
        titleLabel.text = [titleArray objectAtIndex:i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.tag = YLTITLE_LABEL_START_TAG + i;
        [self addSubview:titleLabel];
    }
}
// 初始化当前时间
- (void)__initDate {
    
    NSInteger currentYear = [self currentYear];
    NSInteger currentMonth = [self currentMonth];
//    NSInteger currentDay = [self currentDay];
//    NSInteger currentHour = [self currentHour];
//    NSInteger currentMinute = [self currentMinute];
    
    monthArray = [NSMutableArray array];
    dayArray = [NSMutableArray array];
    hourArray = [NSMutableArray array];
    minutehArray = [NSMutableArray array];
    
    for (NSInteger i = 1; i <= 12; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld", (long)i];
        [monthArray addObject:str];
    }
    [self daysWithYear:currentYear month:currentMonth];
    
    for (NSInteger i = 0; i < 24; i++) {
        NSString *str;
        if (i < 10) {
            str = [NSString stringWithFormat:@"0%ld", (long)i];
        } else {
            str = [NSString stringWithFormat:@"%ld", (long)i];
        }
        [hourArray addObject:str];
    }
    for (NSInteger i = 0; i < 60; i++) {
//        NSString *str = [NSString stringWithFormat:@"%ld", (long)i];
        NSString *str;
        if (i < 10) {
            str = [NSString stringWithFormat:@"0%ld", (long)i];
        } else {
            str = [NSString stringWithFormat:@"%ld", (long)i];
        }
        [minutehArray addObject:str];
    }
    
    // 设置默认
    self.month = monthArray[0];
    self.day = dayArray[0];
    self.hour = hourArray[0];
    self.minute = minutehArray[0];
}

#pragma mark 重置天数
// 获取某一年的某月的天数
- (void)daysWithYear:(NSInteger)year month:(NSInteger)month {
    
    NSInteger totalDay = 0;
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
        totalDay = 31;
    }
    else if(month == 2)
    {
        if (((year % 4 == 0 && year % 100 != 0 ))|| (year % 400 == 0)) {
            totalDay = 29;
        }
        else
        {
            totalDay = 28;
        }
    }
    else
    {
        totalDay = 30;
    }
    
    for (NSInteger i = 1; i <= totalDay; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld", (long)i];
//        NSString *str;
//        if (i < 10) {
//            str = [NSString stringWithFormat:@"0%ld", (long)i];
//        } else {
//            str = [NSString stringWithFormat:@"%ld", (long)i];
//        }
        [dayArray addObject:str];
    }
    
}

// 输出当前年份
- (NSInteger)currentYear {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    NSInteger year = [[[NSString alloc] initWithString:date] intValue];
    return year;
}
// 输出当前月份
- (NSInteger)currentMonth {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    NSInteger month = [[[NSString alloc] initWithString:date] intValue];
    return month;
}

- (void)cancelBtn {
    
    NSLog(@"点击取消");
    UIView *spView = self.superview;
    CGFloat originY = CGRectGetHeight(spView.frame);
    [UIView animateWithDuration:YLDURATION animations:^{
        self.frame = CGRectMake(self.frame.origin.x, originY, self.frame.size.width, self.frame.size.height);
    }];
}

- (void)completionBtn {
    NSLog(@"选择时间是：%@月%@日 %@:%@", self.month, self.day, self.hour, self.minute);
//    NSString *timeString = [NSString stringWithFormat:@"%@月%@日 %@:%@", self.month, self.day, self.hour, self.minute];
    NSString *timeString;
    if ([self.month compare:[NSString stringWithFormat:@"%ld", [self currentMonth]]] == NSOrderedAscending) {
        timeString = [NSString stringWithFormat:@"%ld-%@-%@ %@:%@", (long)[self currentYear] + 1, self.month, self.day, self.hour, self.minute];
    } else {
        timeString = [NSString stringWithFormat:@"%ld-%@-%@ %@:%@", (long)[self currentYear], self.month, self.day, self.hour, self.minute];
    }
    if (self.timePickBlock) {
        self.timePickBlock(timeString);
    }
    UIView *spView = self.superview;
    CGFloat originY = CGRectGetHeight(spView.frame);
    [UIView animateWithDuration:YLDURATION animations:^{
        self.frame = CGRectMake(self.frame.origin.x, originY, self.frame.size.width, self.frame.size.height);
    }];
}

#pragma mark 代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            return [monthArray count];
            break;
        case 1:
            return [dayArray count];
            break;
        case 2:
            return [hourArray count];
            break;
        case 3:
            return [minutehArray count];
            break;
        default:
            return 0;
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *pickerLabel = (UILabel *)view;
    if (pickerLabel == nil) {
        
    }
    float labelWidth = CGRectGetWidth(pickerView.frame) / 4;
    pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, labelWidth, 30.f)];
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    pickerLabel.backgroundColor = [UIColor clearColor];
    pickerLabel.font = [UIFont systemFontOfSize:16.0f];
    switch (component) {
        case 0:
            pickerLabel.text = [monthArray objectAtIndex:row];
            break;
        case 1:
            pickerLabel.text = [dayArray objectAtIndex:row];
            break;
        case 2:
            pickerLabel.text = [hourArray objectAtIndex:row];
            break;
        case 3:
            pickerLabel.text = [minutehArray objectAtIndex:row];
            break;
        default:
            break;
    }
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            [dayArray removeAllObjects];
            [self daysWithYear:[self currentYear] month:row + 1];
            [pickerView reloadComponent:1];
            self.month = monthArray[row];
            break;
        case 1:
            self.day = dayArray[row];
            break;
        case 2:
            self.hour = hourArray[row];
            break;
        case 3:
            self.minute = minutehArray[row];
            break;
        default:
            break;
    }
}



@end

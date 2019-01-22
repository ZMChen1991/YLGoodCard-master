//
//  YLDetailOrderTimeView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailOrderTimeView.h"
#import "YLCondition.h"
#import "YLYearMonthDayPicker.h"
#import "YLTimePicker.h"

@interface YLDetailOrderTimeView ()

//@property (nonatomic, strong) UIButton *time;
@property (nonatomic, strong) NSString *orderTime;
@property (nonatomic, strong) UILabel *date;
@property (nonatomic, strong) UILabel *time;

@end

@implementation YLDetailOrderTimeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, YLScreenWidth, 22)];
    title.text = @"选择看车时间";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:16];
    [self addSubview:title];
    
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(title.frame) + 20, YLScreenWidth / 2, 37)];
    date.textAlignment = NSTextAlignmentRight;
    date.textColor = [UIColor blackColor];
    date.font = [UIFont systemFontOfSize:26];
    date.text = [self stringForDate];
    [date setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateClick)];
    [date addGestureRecognizer:tap];
    [self addSubview:date];
    self.date = date;
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(date.frame) + 20, CGRectGetMaxY(title.frame) + 20, YLScreenWidth / 2, 37)];
    time.textAlignment = NSTextAlignmentLeft;
    time.textColor = [UIColor blackColor];
    time.font = [UIFont systemFontOfSize:26];
    time.text = [self stringForTime];
    [time setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeClick)];
    [time addGestureRecognizer:tap1];
    [self addSubview:time];
    self.time = time;
    
    
//    UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    timeBtn.frame = CGRectMake(0, CGRectGetMaxY(title.frame) + 20, YLScreenWidth, 37);
//    [timeBtn setTitle:[self stringForDate] forState:UIControlStateNormal];
//    [timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [timeBtn addTarget:self action:@selector(selectTime) forControlEvents:UIControlEventTouchUpInside];
//    timeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    timeBtn.titleLabel.font = [UIFont systemFontOfSize:26];
//    [self addSubview:timeBtn];
//    self.time = timeBtn;
    
    UILabel *warning = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(date.frame) + 20, YLScreenWidth, 17)];
    warning.text = @"多人已关注，预计很快售出，建议尽早预约";
    warning.textAlignment = NSTextAlignmentCenter;
    warning.font = [UIFont systemFontOfSize:12];
    [self addSubview:warning];
    
    CGFloat btnW = (YLScreenWidth - 2 * YLLeftMargin - 10) / 2;
    YLCondition *cancel = [[YLCondition alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(warning.frame) + 20, btnW, 40)];
    cancel.type = YLConditionTypeWhite;
    [cancel setTitle:@"取消看车" forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    
    
    YLCondition *orderCar = [[YLCondition alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancel.frame) + 10,  CGRectGetMaxY(warning.frame) + 20, btnW, 40)];
    orderCar.type = YLConditionTypeBlue;
    [orderCar setTitle:@"预约看车" forState:UIControlStateNormal];
    orderCar.titleLabel.font = [UIFont systemFontOfSize:14];
    [orderCar addTarget:self action:@selector(orderCar) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:orderCar];
    
    
//    YLYearMonthDayPicker *picker = [[YLYearMonthDayPicker alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    [self addSubview:picker];
    
//    YLAllTimePicker *timePicker = [[YLAllTimePicker alloc] initWithFrame:CGRectMake(0, 213, YLScreenWidth, 213)];
////    timePicker.backgroundColor = [UIColor redColor];
//    __weak typeof(self) weakSelf = self;
//    timePicker.cancelBlock = ^{
//        NSLog(@"退出时间选择器");
//        [UIView animateWithDuration:0.25 animations:^{
//            CGFloat timePickerY = 213;
//            weakSelf.timePicker.frame = CGRectMake(0, timePickerY, YLScreenWidth, 213);
//        }];
//    };
//
//    timePicker.sureBlock = ^(NSString * _Nonnull checkOut) {
//
//        self.orderTime = checkOut;
//        NSLog(@"预约看车时间:%@-orderTime:%@", checkOut, self.orderTime);
//        [weakSelf.time setTitle:checkOut forState:UIControlStateNormal];
//        NSLog(@"退出时间选择器");
//        [UIView animateWithDuration:0.25 animations:^{
//            CGFloat timePickerY = 213;
//            weakSelf.timePicker.frame = CGRectMake(0, timePickerY, YLScreenWidth, 213);
//        }];
//    };
//    [self addSubview:timePicker];
//    self.timePicker = timePicker;
    
}

- (void)cancel {
    NSLog(@"取消预约看车");
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)orderCar {
    self.orderTime = [NSString stringWithFormat:@"%@ %@", self.date.text, self.time.text];
    NSLog(@"确定预约看车:%@", self.orderTime);
    if (self.orderTimeBlock) {
        self.orderTimeBlock(self.orderTime);
    }
}

- (void)dateClick {
    NSLog(@"选择日期, 弹出日期弹窗");
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    cover.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5];
    __weak typeof(self) weakSelf = self;
    YLYearMonthDayPicker *picker = [[YLYearMonthDayPicker alloc] initWithFrame:CGRectMake(0, 250, YLScreenWidth, 150)];
    picker.cancelBlock = ^{
        [cover removeFromSuperview];
    };
    picker.sureBlock = ^(NSString * _Nonnull licenseTime) {
        weakSelf.date.text = licenseTime;
        [cover removeFromSuperview];
    };
    
    [cover addSubview:picker];
    [window addSubview:cover];
    
}

- (void)timeClick {
    NSLog(@"选择时间, 弹出时间弹窗");
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    cover.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5];
    __weak typeof(self) weakSelf = self;
    YLTimePicker *picker = [[YLTimePicker alloc] initWithFrame:CGRectMake(0, 250, YLScreenWidth, 150)];
    picker.cancelBlock = ^{
        [cover removeFromSuperview];
    };
    
    picker.sureBlock = ^(NSString * _Nonnull time) {
        weakSelf.time.text = time;
        [cover removeFromSuperview];
    };
    
    [cover addSubview:picker];
    [window addSubview:cover];
}

//- (void)selectTime {
//    NSLog(@"选择时间,弹出时间选择器");
////    [UIView animateWithDuration:0.25 animations:^{
////        CGFloat timePickerY = 0;
////        self.timePicker.frame = CGRectMake(0, timePickerY, YLScreenWidth, 213);
////    }];
//}

- (NSString *)stringForDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

- (NSString *)stringForTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

@end

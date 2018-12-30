//
//  YLDetailOrderTimeView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailOrderTimeView.h"
#import "YLCondition.h"
//#import "YLTimePickView.h"
#import "YLAllTimePicker.h"

@interface YLDetailOrderTimeView ()

@property (nonatomic, strong) UIButton *time;
@property (nonatomic, strong) YLAllTimePicker *timePicker;
@property (nonatomic, strong) NSString *orderTime;

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
    
    UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame = CGRectMake(0, CGRectGetMaxY(title.frame) + 20, YLScreenWidth, 37);
    [timeBtn setTitle:[self stringForDate] forState:UIControlStateNormal];
    [timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [timeBtn addTarget:self action:@selector(selectTime) forControlEvents:UIControlEventTouchUpInside];
    timeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    timeBtn.titleLabel.font = [UIFont systemFontOfSize:26];
    [self addSubview:timeBtn];
    self.time = timeBtn;
    
    UILabel *warning = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(timeBtn.frame) + 20, YLScreenWidth, 17)];
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
    
    
    YLAllTimePicker *timePicker = [[YLAllTimePicker alloc] initWithFrame:CGRectMake(0, 213, YLScreenWidth, 213)];
//    timePicker.backgroundColor = [UIColor redColor];
    __weak typeof(self) weakSelf = self;
    timePicker.cancelBlock = ^{
        NSLog(@"退出时间选择器");
        [UIView animateWithDuration:0.25 animations:^{
            CGFloat timePickerY = 213;
            weakSelf.timePicker.frame = CGRectMake(0, timePickerY, YLScreenWidth, 213);
        }];
    };

    timePicker.sureBlock = ^(NSString * _Nonnull checkOut) {
        
        self.orderTime = checkOut;
        NSLog(@"预约看车时间:%@-orderTime:%@", checkOut, self.orderTime);
        [weakSelf.time setTitle:checkOut forState:UIControlStateNormal];
        NSLog(@"退出时间选择器");
        [UIView animateWithDuration:0.25 animations:^{
            CGFloat timePickerY = 213;
            weakSelf.timePicker.frame = CGRectMake(0, timePickerY, YLScreenWidth, 213);
        }];
    };
    [self addSubview:timePicker];
    self.timePicker = timePicker;
    
}

- (void)cancel {
    NSLog(@"取消预约看车");
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)orderCar {
    
    NSLog(@"确定预约看车");
    if (self.orderTimeBlock) {
        self.orderTimeBlock(self.orderTime);
    }
}

- (void)selectTime {
    NSLog(@"选择时间,弹出时间选择器");
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat timePickerY = 0;
        self.timePicker.frame = CGRectMake(0, timePickerY, YLScreenWidth, 213);
    }];
}

- (NSString *)stringForDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

@end

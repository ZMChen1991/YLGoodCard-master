//
//  YLCoverView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/9.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCoverView.h"
#import "YLCondition.h"
#import "YLTimePickView.h"

@interface YLCoverView ()

//@property (nonatomic, assign) float sale; // 卖家出价
@property (nonatomic, strong) UILabel *buye; // 买家出价
@property (nonatomic, strong) UILabel *saler;// 卖家出价
@property (nonatomic, strong) UISlider *slider; // 滚动条
@property (nonatomic, strong) UIButton *time;// 预约看车时间
@property (nonatomic, strong) NSString *timeString;

@end

@implementation YLCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        [self setupBargainBg];
        [self setupOrderBg];
    }
    return self;
}

- (void)setupOrderBg {
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 213, self.frame.size.width, 213)];
    bg.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, YLScreenWidth, 22)];
    title.text = @"选择看车时间";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:16];
    
    UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame = CGRectMake(0, CGRectGetMaxY(title.frame) + 20, YLScreenWidth, 37);
    [timeBtn setTitle:[self stringForDate] forState:UIControlStateNormal];
    [timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [timeBtn addTarget:self action:@selector(selectTime) forControlEvents:UIControlEventTouchUpInside];
    timeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    timeBtn.titleLabel.font = [UIFont systemFontOfSize:26];
    self.time = timeBtn;
    
    UILabel *warning = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(timeBtn.frame) + 20, YLScreenWidth, 17)];
    warning.text = @"多人已关注，预计很快售出，建议尽早预约";
    warning.textAlignment = NSTextAlignmentCenter;
    warning.font = [UIFont systemFontOfSize:12];
    
    YLCondition *orderCar = [[YLCondition alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(warning.frame) + 20, YLScreenWidth - 2 * YLLeftMargin, 40)];
    orderCar.type = YLConditionTypeBlue;
    [orderCar setTitle:@"预约看车" forState:UIControlStateNormal];
    [orderCar addTarget:self action:@selector(orderCar) forControlEvents:UIControlEventTouchUpInside];
    
    [bg addSubview:title];
    [bg addSubview:timeBtn];
    [bg addSubview:warning];
    [bg addSubview:orderCar];
    [self addSubview:bg];
    self.orderBg = bg;
}

- (void)setupBargainBg {
    
    float width = YLScreenWidth / 2;
    float height = 22;
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 213, self.frame.size.width, 213)];
    bg.backgroundColor = [UIColor whiteColor];

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, YLScreenWidth, height)];
    title.text = @"选择砍价金额";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:16];
    
    // 宽一半，高：22，间距：12
    UILabel *sale = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame) + 12, width, height)];
    sale.text = @"0.0万";
    sale.textAlignment = NSTextAlignmentCenter;
    sale.font = [UIFont systemFontOfSize:20];
    self.saler = sale;
    
    UILabel *buye = [[UILabel alloc] initWithFrame:CGRectMake(width, CGRectGetMaxY(title.frame) + 12, width, height)];
    buye.text = @"0.00万";
    buye.textAlignment = NSTextAlignmentCenter;
    buye.font = [UIFont systemFontOfSize:20];
    self.buye = buye;
    
    UILabel *saler = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sale.frame), width, height)];
    saler.text = @"卖家出价";
    saler.textAlignment = NSTextAlignmentCenter;
    saler.font = [UIFont systemFontOfSize:14];
    
    UILabel *buyer = [[UILabel alloc] initWithFrame:CGRectMake(width, CGRectGetMaxY(sale.frame), width, height)];
    buyer.text = @"您的出价";
    buyer.textAlignment = NSTextAlignmentCenter;
    buyer.font = [UIFont systemFontOfSize:14];
    
    // 上下间距：20  左右：15
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(saler.frame) + YLLeftMargin, YLScreenWidth - 2 * YLLeftMargin, 10)];
    // 设置最小值最大值
    slider.minimumValue = 0;
//    slider.maximumValue = 20; // 获取卖家价格
    slider.continuous = YES;
    [slider addTarget:self action:@selector(changeBuy:) forControlEvents:UIControlEventValueChanged];
//    slider.backgroundColor = [UIColor redColor];
    self.slider = slider;
    
    
    CGFloat btnW = (YLScreenWidth - 2 * YLLeftMargin - 10) / 2;
    YLCondition *cancel = [[YLCondition alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(slider.frame) + YLLeftMargin, btnW, 40)];
    cancel.type = YLConditionTypeWhite;
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    YLCondition *bargain = [[YLCondition alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancel.frame) + 10, CGRectGetMaxY(slider.frame) + YLLeftMargin, btnW, 40)];
    bargain.type = YLConditionTypeBlue;
    [bargain setTitle:@"砍价" forState:UIControlStateNormal];
    [bargain addTarget:self action:@selector(bargain) forControlEvents:UIControlEventTouchUpInside];
    
    [bg addSubview:title];
    [bg addSubview:sale];
    [bg addSubview:buye];
    [bg addSubview:saler];
    [bg addSubview:buyer];
    [bg addSubview:slider];
    [bg addSubview:bargain];
    [bg addSubview:cancel];
    [self addSubview:bg];
    self.bargainBg = bg;
}

- (void)changeBuy:(UISlider *)sender {
    
//    NSLog(@"%f", sender.value);
    self.buye.text = [NSString stringWithFormat:@"%.2f万",sender.value];
}
- (void)cancelClick {
    NSLog(@"点击了取消");
}

- (void)bargain {
    
    NSLog(@"点击了砍价");
    if (self.bargainBlock) {
        self.bargainBlock(self.buye.text);
    }
    self.hidden = YES;
}

- (void)orderCar {
    
    NSLog(@"YLCoverView:预约看车");
    if (self.timePickerBlock) {
        self.timePickerBlock(self.timeString);
    }
    self.hidden = YES;
}

- (void)selectTime {
    
    NSLog(@"选择时间");
    YLTimePickView *timePicker = [[YLTimePickView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 213, YLScreenWidth, 213)];
    timePicker.timePickBlock = ^(NSString *timeString) {
        NSLog(@"选择的时间是%@", timeString);
        self.timeString = timeString;
        [self.time setTitle:timeString forState:UIControlStateNormal];
    };
    [self addSubview:timePicker];
}

- (void)setSalePrice:(NSString *)salePrice {
    _salePrice = salePrice;
    NSString *price = [NSString stringWithFormat:@"%.2f万", [salePrice floatValue] / 10000];
    self.saler.text = price;
    self.slider.maximumValue = [salePrice floatValue] / 10000;
}


- (NSString *)stringForDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}
@end

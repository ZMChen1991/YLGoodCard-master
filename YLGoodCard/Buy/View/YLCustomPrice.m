//
//  YLCustomPrice.m
//  YLGoodCard
//
//  Created by lm on 2018/11/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCustomPrice.h"
#import "YLCondition.h"

@interface YLCustomPrice () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *lowPrice;
@property (nonatomic, strong) UITextField *highPrice;
@property (nonatomic, strong) YLCondition *sureBtn;

@end

@implementation YLCustomPrice

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    // 添加价格选择
    NSArray *prices = @[@"不限", @"3万以下", @"3-5万", @"5-7万", @"7-9万", @"9-12万", @"12-16万", @"16-20万", @"20万以上"];
    float btnW = self.frame.size.width / 3;
    float btnH = 20;
    for (int i = 0; i < prices.count; i++) {
        int row = i / 3;
        int line = i % 3;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(line * btnW, row * (btnH + YLLeftMargin) + YLLeftMargin, btnW, btnH);
        [btn setTitle:prices[i] forState:UIControlStateNormal];
        [btn setTitleColor:YLColor(116.f, 116.f, 116.f) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(clickPrice:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    // 分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, (btnH + YLLeftMargin) * 3 + YLLeftMargin, self.frame.size.width, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
    
    // 自定义价格
    UILabel *customPrice = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(line.frame) + YLLeftMargin, 112, btnH)];
    customPrice.text = @"自定义价格(万)";
    customPrice.textColor = YLColor(172.f, 172.f, 172.f);
    customPrice.font = [UIFont systemFontOfSize:14];
    [self addSubview:customPrice];
    
    UITextField *lowPrice = [[UITextField alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(customPrice.frame)+YLMargin, 80, 30)];
    lowPrice.placeholder = @"最低价";
    lowPrice.textAlignment = NSTextAlignmentCenter;
    lowPrice.font = [UIFont systemFontOfSize:15];
    lowPrice.delegate = self;
    [self addSubview:lowPrice];
    self.lowPrice = lowPrice;

    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lowPrice.frame) + YLMargin, CGRectGetMaxY(customPrice.frame) + YLLeftMargin + 15, 9, 1)];
    line1.backgroundColor = [UIColor blackColor];
    [self addSubview:line1];
    
    UITextField *highPrice = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame)+YLMargin, CGRectGetMaxY(customPrice.frame)+YLTopMargin, 80, 30)];
    highPrice.placeholder = @"最高价";
//    highPrice.backgroundColor = [UIColor redColor];
    highPrice.textAlignment = NSTextAlignmentCenter;
    highPrice.font = [UIFont systemFontOfSize:15];
    highPrice.delegate = self;
    [self addSubview:highPrice];
    self.highPrice = highPrice;
    
    YLCondition *sureBtn = [[YLCondition alloc] initWithFrame:CGRectMake(self.frame.size.width - 80 - YLLeftMargin, CGRectGetMaxY(customPrice.frame)+YLTopMargin, 80, 30)];
    sureBtn.type = YLConditionTypeBlue;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    self.sureBtn = sureBtn;
}

- (void)sureClick {
    
    NSLog(@"点击确定");
    self.sureBtn.userInteractionEnabled = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushLowPrice:highPrice:)]) {
        [self.delegate pushLowPrice:self.lowPrice.text highPrice:self.highPrice.text];
    }
}

- (void)clickPrice:(UIButton *)sender {
    
    NSLog(@"%@", sender.titleLabel.text);
    if (self.customPriceBlock) {
        self.customPriceBlock(sender);
    }
}

@end

//
//  YLOrderView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLOrderView.h"
#import "YLCondition.h"

@interface YLOrderView ()

@property (nonatomic, strong) YLCondition *saleBtn; // 预约卖车
@property (nonatomic, strong) YLCondition *consultBtn; // 免费咨询

@end

@implementation YLOrderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupOriginal];
    }
    return self;
}

- (void)setupOriginal {
    
    self.saleBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    [self.saleBtn setTitle:@"预约卖车" forState:UIControlStateNormal];
    self.saleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.saleBtn.type = YLConditionTypeBlue;
    [self.saleBtn addTarget:self action:@selector(sale:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.saleBtn];
    
    self.consultBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    [self.consultBtn setTitle:@"免费咨询" forState:UIControlStateNormal];
    self.consultBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.consultBtn.type = YLConditionTypeWhite;
    [self.consultBtn addTarget:self action:@selector(consult:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.consultBtn];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    float saleBtnX = YLMargin;
    float saleBtnY = YLMargin;
    float saleBtnW = self.frame.size.width - 2 * YLMargin;
    float saleBtnH = 50;
    self.saleBtn.frame = CGRectMake(saleBtnX, saleBtnY, saleBtnW, saleBtnH);
    
    float consultBtnX = YLMargin;
    float consultBtnY = CGRectGetMaxY(self.saleBtn.frame) + YLMargin;
    float consultBtnW = saleBtnW;
    float consultBtnH = saleBtnH;
    self.consultBtn.frame = CGRectMake(consultBtnX, consultBtnY, consultBtnW, consultBtnH);
}

- (void)sale:(UIButton *)sender {
    
    NSLog(@"预约卖车:%@", sender.titleLabel.text);
    if (self.orderSaleBlock) {
        self.orderSaleBlock();
    }
    
}

- (void)consult:(UIButton *)sender {
    
    NSLog(@"免费咨询:%@", sender.titleLabel.text);
    if (self.consultBlock) {
        self.consultBlock();
    }
}

@end

//
//  YLSaleView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSaleView.h"

@interface YLSaleView ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *numberL;
@property (nonatomic, strong) UITextField *telephoneT;
@property (nonatomic, strong) UILabel *label1; // 位车主提交卖车申请

@end

@implementation YLSaleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupOriginal];
    }
    return self;
}

- (void)setupOriginal {
    
    UIImageView *icon = [[UIImageView alloc] init];
//    icon.backgroundColor = YLRandomColor;
    icon.image = [UIImage imageNamed:@"汽车"];
    [self addSubview:icon];
    self.icon = icon;
    
    UILabel *numberL = [[UILabel alloc] init];
    numberL.textColor = YLColor(8.f, 169.f, 255.f);
    numberL.text = @"123456";
    numberL.textAlignment = NSTextAlignmentCenter;
    numberL.font = [UIFont systemFontOfSize:30];
    [self addSubview:numberL];
    self.numberL = numberL;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"位车主提交了卖车申请";
    label1.textColor = [UIColor blackColor];
//    label1.backgroundColor = YLRandomColor;
    [self addSubview:label1];
    self.label1 = label1;
    
    self.saleBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    [self.saleBtn setTitle:@"预约卖车" forState:UIControlStateNormal];
    self.saleBtn.type = YLConditionTypeBlue;
    self.saleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.saleBtn.tag = 301;
    [self.saleBtn addTarget:self action:@selector(sale:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.saleBtn];
    
    self.consultBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    [self.consultBtn setTitle:@"免费咨询" forState:UIControlStateNormal];
    self.consultBtn.type = YLConditionTypeWhite;
    self.consultBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.consultBtn.tag = 302;
    [self.consultBtn addTarget:self action:@selector(consult:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.consultBtn];
    
    self.appraiseBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    [self.appraiseBtn setTitle:@"爱车估价" forState:UIControlStateNormal];
    self.appraiseBtn.type = YLConditionTypeWhite;
    self.appraiseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.appraiseBtn.tag = 303;
    [self.appraiseBtn addTarget:self action:@selector(appraise:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.appraiseBtn];
    
    UITextField *telephone = [[UITextField alloc] init];
    telephone.placeholder = @"请输入手机号";
    telephone.layer.borderWidth = 0.6;
    telephone.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    telephone.layer.cornerRadius = 5;
    telephone.layer.masksToBounds = YES;
    telephone.backgroundColor = [UIColor whiteColor];
    [self addSubview:telephone];
    self.telephoneT = telephone;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    float margin = 15;
    float margin1 = 10;
    float iconW = self.frame.size.width;
    float iconH = 130;
    self.icon.frame = CGRectMake(0, 64, iconW, iconH);
    
    float numberX = margin;
    float numberY = CGRectGetMaxY(self.icon.frame) + margin;
    float numberW = 116;
    float numberH = 36;
    self.numberL.frame = CGRectMake(numberX, numberY, numberW, numberH);
    
    float label1X = CGRectGetMaxX(self.numberL.frame) + margin1;
    float label1Y = numberY;
    float label1W = 200;
    float label1H = numberH;
    self.label1.frame = CGRectMake(label1X, label1Y, label1W, label1H);
    
    float telephoneX = numberX;
    float telephoneY = CGRectGetMaxY(self.numberL.frame) + margin1;
    float telephoneW = iconW - 2 * margin;
    float telephoneH = 40;
    self.telephoneT.frame = CGRectMake(telephoneX, telephoneY, telephoneW, telephoneH);
    
    float salaBtnX = margin;
    float salaBtnY = CGRectGetMaxY(self.telephoneT.frame) + margin1;
    float salaBtnW = iconW - 2 * margin;
    float salaBtnH = 40;
    self.saleBtn.frame = CGRectMake(salaBtnX, salaBtnY, salaBtnW, salaBtnH);
    
    float consultBtnX = margin;
    float consultBtnY = CGRectGetMaxY(self.saleBtn.frame) + margin1;
    float consultBtnW = (iconW - 2 * margin - margin1) / 2;
    float consultBtnH = salaBtnH;
    self.consultBtn.frame = CGRectMake(consultBtnX, consultBtnY, consultBtnW, consultBtnH);
    
    float appraiseBtnX = CGRectGetMaxX(self.consultBtn.frame) + margin1;
    float appraiseBtnY = consultBtnY;
    float appraiseBtnW = consultBtnW;
    float appraiseBtnH = consultBtnH;
    self.appraiseBtn.frame = CGRectMake(appraiseBtnX, appraiseBtnY, appraiseBtnW, appraiseBtnH);
    
}

// 估价
- (void)appraise:(UIButton *)sender {
    
    NSLog(@"点击了估价按钮");
    [self.telephoneT resignFirstResponder];
    if (self.appraiseBtn.delegate && [self.appraiseBtn.delegate respondsToSelector:@selector(pushController:)]) {
        [self.appraiseBtn.delegate pushController:sender];
    }
    if (self.appraiseBlock) {
        self.appraiseBlock(self.telephoneT.text);
    }
}
// 咨询
- (void)consult:(UIButton *)sender {
    
    NSLog(@"点击了咨询按钮");
    [self.telephoneT resignFirstResponder];
    if (self.consultBtn.delegate && [self.consultBtn.delegate respondsToSelector:@selector(pushController:)]) {
        [self.consultBtn.delegate pushController:sender];
    }
}
// 预约卖车
- (void)sale:(UIButton *)sender {
    
    NSLog(@"点击了预约卖车按钮");
    [self.telephoneT resignFirstResponder];
    if (self.saleBtn.delegate && [self.saleBtn.delegate respondsToSelector:@selector(pushController:)]) {
        [self.saleBtn.delegate pushController:sender];
    }
    if (self.saleTelBlock) {
        self.saleTelBlock(self.telephoneT.text);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.telephoneT resignFirstResponder];
}

- (void)setTelephone:(NSString *)telephone {
    _telephone = telephone;
    self.telephoneT.text = telephone;
}

@end

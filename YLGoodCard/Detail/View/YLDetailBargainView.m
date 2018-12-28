//
//  YLDetailBargainView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailBargainView.h"
#import "YLCondition.h"

@interface YLDetailBargainView ()

@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *saler;
@property (nonatomic, strong) UILabel *buye;

@end

@implementation YLDetailBargainView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    float width = YLScreenWidth / 2;
    float height = 22;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, YLScreenWidth, height)];
    title.text = @"选择砍价金额";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:16];
    [self addSubview:title];
    
    // 宽一半，高：22，间距：12
    UILabel *sale = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame) + 12, width, height)];
    sale.text = @"0.0万";
    sale.textAlignment = NSTextAlignmentCenter;
    sale.font = [UIFont systemFontOfSize:20];
    [self addSubview:sale];
    self.saler = sale;
    
    UILabel *buye = [[UILabel alloc] initWithFrame:CGRectMake(width, CGRectGetMaxY(title.frame) + 12, width, height)];
    buye.text = @"0.00万";
    buye.textAlignment = NSTextAlignmentCenter;
    buye.font = [UIFont systemFontOfSize:20];
    [self addSubview:buye];
    self.buye = buye;
    
    UILabel *saler = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sale.frame), width, height)];
    saler.text = @"卖家出价";
    saler.textAlignment = NSTextAlignmentCenter;
    saler.font = [UIFont systemFontOfSize:14];
    [self addSubview:saler];
    
    UILabel *buyer = [[UILabel alloc] initWithFrame:CGRectMake(width, CGRectGetMaxY(sale.frame), width, height)];
    buyer.text = @"您的出价";
    buyer.textAlignment = NSTextAlignmentCenter;
    buyer.font = [UIFont systemFontOfSize:14];
    [self addSubview:buyer];
    
    // 上下间距：20  左右：15
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(saler.frame) + YLLeftMargin, YLScreenWidth - 2 * YLLeftMargin, 10)];
    // 设置最小值最大值
    slider.minimumValue = 0;
    slider.maximumValue = 1; // 获取卖家价格
    slider.value = 1;
    slider.continuous = YES;
    [slider addTarget:self action:@selector(changeBuy:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:slider];
    self.slider = slider;
    
    
    CGFloat btnW = (YLScreenWidth - 2 * YLLeftMargin - 10) / 2;
    YLCondition *cancel = [[YLCondition alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(slider.frame) + 2 * YLLeftMargin, btnW, 40)];
    cancel.type = YLConditionTypeWhite;
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    
    YLCondition *bargain = [[YLCondition alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancel.frame) + 10, CGRectGetMaxY(slider.frame) + 2 * YLLeftMargin, btnW, 40)];
    bargain.type = YLConditionTypeBlue;
    [bargain setTitle:@"砍价" forState:UIControlStateNormal];
    [bargain addTarget:self action:@selector(bargain) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bargain];
}

- (void)cancelClick {
    NSLog(@"点击了取消");
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)bargain {
    
    NSLog(@"点击了砍价:%@", self.buye.text);
    NSString *price = [NSString stringWithFormat:@"%.f", [self.buye.text floatValue] * 10000];
    if (self.bargainBlock) {
        self.bargainBlock(price);
    }
    self.hidden = YES;
}

- (void)changeBuy:(UISlider *)sender {
    float buyPrice = [self.salePrice floatValue] * sender.value;
    NSString *price = [NSString stringWithFormat:@"%f", buyPrice];
    self.buye.text = [self stringWithValue:price];
}

- (void)setSalePrice:(NSString *)salePrice {
    _salePrice = salePrice;
    self.saler.text = [self stringWithValue:salePrice];
    self.buye.text = [self stringWithValue:salePrice];
}

- (NSString *)stringWithValue:(NSString *)price {
    NSString *str = [NSString stringWithFormat:@"%.1f万", [price floatValue] / 10000];
    return str;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}
@end

//
//  YLBargainPriceView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBargainPriceView.h"
#import "YLCondition.h"

@interface YLBargainPriceView ()

//@property (nonatomic, strong) NSString *buyerPrice;
//@property (nonatomic, strong) NSString *dickerPrice;
@property (nonatomic, strong) UILabel *dickerPriceL;
@property (nonatomic, strong) UILabel *buyerPriceL;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation YLBargainPriceView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, YLScreenWidth, 22)];
    title.text = @"选择还价金额";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:16];
    [self addSubview:title];
    
    UILabel *buyerPriceL = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame) + 10, YLScreenWidth /2, 28)];
    buyerPriceL.textAlignment = NSTextAlignmentCenter;
    buyerPriceL.text = @"10.0万";
    buyerPriceL.font = [UIFont systemFontOfSize:20];
    [self addSubview:buyerPriceL];
    self.buyerPriceL = buyerPriceL;
    
    UILabel *buyer = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(buyerPriceL.frame), YLScreenWidth /2, 28)];
    buyer.textAlignment = NSTextAlignmentCenter;
    buyer.text = @"买家出价";
    buyer.textColor = YLColor(155.f, 155.f, 155.f);
    buyer.font = [UIFont systemFontOfSize:14];
    [self addSubview:buyer];
    
    
    UILabel *dickerPriceL = [[UILabel alloc] initWithFrame:CGRectMake(YLScreenWidth / 2, CGRectGetMaxY(title.frame) + 10, YLScreenWidth /2, 28)];
    dickerPriceL.textAlignment = NSTextAlignmentCenter;
    dickerPriceL.text = @"12万";
    dickerPriceL.font = [UIFont systemFontOfSize:20];
    [self addSubview:dickerPriceL];
    self.dickerPriceL = dickerPriceL;
    
    UILabel *dicker = [[UILabel alloc] initWithFrame:CGRectMake(YLScreenWidth / 2, CGRectGetMaxY(dickerPriceL.frame), YLScreenWidth /2, 28)];
    dicker.textAlignment = NSTextAlignmentCenter;
    dicker.text = @"您的出价";
    dicker.textColor = YLColor(155.f, 155.f, 155.f);
    dicker.font = [UIFont systemFontOfSize:14];
    [self addSubview:dicker];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(buyer.frame) + 20, YLScreenWidth - 2 * YLLeftMargin, 16)];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    slider.continuous = YES;
    [slider addTarget:self action:@selector(changePrice:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:slider];
    self.slider = slider;
    
    YLCondition *dickerBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    dickerBtn.type = YLConditionTypeBlue;
    dickerBtn.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(slider.frame) + YLLeftMargin, YLScreenWidth - 2 * YLLeftMargin, 40);
    [dickerBtn setTitle:@"还价" forState:UIControlStateNormal];
    [dickerBtn addTarget:self action:@selector(dickerClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dickerBtn];
    
}

- (void)changePrice:(UISlider *)sender {
    NSLog(@"拖动滑条:%f", sender.value);
    self.dickerPriceL.text = [NSString stringWithFormat:@"%.2f", sender.value];
}

- (void)dickerClick {
    
    NSLog(@"YLBargainPriceView:点击还价");
    if (self.bargainPriceBlock) {
        self.bargainPriceBlock(self.dickerPriceL.text);
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}
@end

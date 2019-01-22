//
//  YLSubscribePriceCell.m
//  YLGoodCard
//
//  Created by lm on 2019/1/19.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLSubscribePriceCell.h"

@interface YLSubscribePriceCell () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *lowPriceT;
@property (nonatomic, strong) UITextField *highPriceT;

@end

@implementation YLSubscribePriceCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UILabel *title = [[UILabel alloc] init];
    title.textAlignment = NSTextAlignmentLeft;
    title.text = @"价格(单位:万):";
    title.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:title];
    
    UITextField *lowPriceT = [[UITextField alloc] init];
    lowPriceT.placeholder = @"最低价";
    lowPriceT.textAlignment = NSTextAlignmentCenter;
    lowPriceT.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:lowPriceT];
    self.lowPriceT = lowPriceT;
    
    
    
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}


@end

//
//  YLConfigHeaderView.m
//  YLGoodCard
//
//  Created by lm on 2019/1/3.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLConfigHeaderView.h"

@interface YLConfigHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *originalPriceLabel;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *label1;


@end

@implementation YLConfigHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.frame = CGRectMake(YLLeftMargin, 10, YLScreenWidth - 2 * YLLeftMargin, 44);
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = YLColor(51.f, 51.f, 51.f);
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = YLColor(155.f, 155.f, 155.f);
    label.text = @"车主报价";
    label.font = [UIFont systemFontOfSize:12];
//    label.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(titleLabel.frame) + 17, 50, 17);
    [self addSubview:label];
    self.label = label;
    
    UILabel *priceLabel = [[UILabel alloc] init];
//    priceLabel.frame = CGRectMake(CGRectGetMaxX(label.frame) + 5, CGRectGetMaxY(titleLabel.frame) + 10, 70, 30);
    priceLabel.textColor = YLColor(208.f, 2.f, 27.f);
    priceLabel.font = [UIFont systemFontOfSize:22];
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = YLColor(155.f, 155.f, 155.f);
    label1.text = @"新车含税价";
    label1.font = [UIFont systemFontOfSize:12];
//    label1.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(titleLabel.frame) + 17, 52, 17);
    [self addSubview:label1];
    self.label1 = label1;
//    self.label1.backgroundColor = [UIColor redColor];
    
    UILabel *originalPriceLabel = [[UILabel alloc] init];
    originalPriceLabel.textColor = YLColor(155.f, 155.f, 155.f);
    originalPriceLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:originalPriceLabel];
    self.originalPriceLabel = originalPriceLabel;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

- (void)setModel:(YLDetailModel *)model {
    _model = model;
    
    self.titleLabel.frame = CGRectMake(YLLeftMargin, 10, YLScreenWidth - 2 * YLLeftMargin, 44);
    self.label.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(self.titleLabel.frame) + 17, 50, 17);
    CGSize size = [[self stringToNumber:model.price] getSizeWithFont:[UIFont systemFontOfSize:22]];
    self.priceLabel.frame = CGRectMake(CGRectGetMaxX(self.label.frame) + 5, CGRectGetMaxY(self.titleLabel.frame) + 10, size.width + 10, 30);
    self.label1.frame = CGRectMake(CGRectGetMaxX(self.priceLabel.frame) + 5, CGRectGetMaxY(self.titleLabel.frame) + 17, 65, 17);
    self.originalPriceLabel.frame = CGRectMake(CGRectGetMaxX(self.label1.frame) + 5, CGRectGetMaxY(self.titleLabel.frame) + 17, 100, 17);
    
    self.titleLabel.text = model.title;
    self.priceLabel.text = [self stringToNumber:model.price];
    NSString *str = [self stringToNumber:model.originalPrice];
    NSDictionary *attri = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attri];
    self.originalPriceLabel.attributedText = attriStr;
}

- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}

@end

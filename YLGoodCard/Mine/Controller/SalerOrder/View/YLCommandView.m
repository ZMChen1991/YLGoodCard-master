//
//  YLCommandView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCommandView.h"

#define YLTopSpace 10

@interface YLCommandView ()

@property (nonatomic, strong) UIImageView *icon; // 图片
@property (nonatomic, strong) UILabel *title; // 名称
@property (nonatomic, strong) UILabel *course; // 年/万公里
@property (nonatomic, strong) UILabel *price; // 销售价格
@property (nonatomic, strong) UILabel *originalPrice; // 新车价

@end

@implementation YLCommandView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.backgroundColor = [UIColor redColor];
    icon.layer.cornerRadius = 5.f;
    icon.layer.masksToBounds = YES;
    [self addSubview:icon];
    self.icon = icon;
    
    UILabel *title = [[UILabel alloc] init];
    title.textColor = [UIColor blackColor];
    title.font = [UIFont systemFontOfSize:14];
    title.numberOfLines = 0;
    [self addSubview:title];
    self.title = title;
    
    UILabel *course = [[UILabel alloc] init];
    course.textColor = [UIColor blackColor];
    course.font = [UIFont systemFontOfSize:12];
    course.textAlignment = NSTextAlignmentLeft;
    [self addSubview:course];
    self.course = course;
    
    UILabel *originalPrice = [[UILabel alloc] init];
    originalPrice.font = [UIFont systemFontOfSize:12];
    originalPrice.textAlignment = NSTextAlignmentLeft;
    [self addSubview:originalPrice];
    self.originalPrice = originalPrice;
    
    UILabel *price = [[UILabel alloc] init];
    price.textColor = [UIColor redColor];
    price.font = [UIFont systemFontOfSize:18];
    [self addSubview:price];
    self.price = price;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.icon.frame = CGRectMake(YLLeftMargin, YLTopSpace, 120, 86);
    
    float titleX = CGRectGetMaxX(self.icon.frame) + YLLeftMargin;
    float titleW = YLScreenWidth - 120 - 2 * YLLeftMargin - YLTopSpace;
    self.title.frame = CGRectMake(titleX, YLTopSpace, titleW, 34);
    
    self.course.frame = CGRectMake(titleX, CGRectGetMaxY(self.title.frame) + 5, titleW, 17);
    
    self.price.frame = CGRectMake(titleX, CGRectGetMaxY(self.course.frame) + 5, titleW/3, 25);
    
    self.originalPrice.frame = CGRectMake(CGRectGetMaxX(self.price.frame), CGRectGetMaxY(self.course.frame) + 9, YLScreenWidth - CGRectGetMaxX(self.price.frame) - YLTopSpace, 17);
    
    self.title.text = @"xxxxx";
    self.price.text = @"12.9万";
    self.course.text = @"25万公里/年";
    self.originalPrice.text = @"新车含税价25.6万";
    
}

@end

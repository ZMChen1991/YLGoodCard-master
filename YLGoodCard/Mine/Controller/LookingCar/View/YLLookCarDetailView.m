//
//  YLLookCarDetailView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLLookCarDetailView.h"

#define YLTopSpace 12

@interface YLLookCarDetailView ()

@property (nonatomic, strong) UIImageView *icon; // 图片
@property (nonatomic, strong) UILabel *title; // 名称
@property (nonatomic, strong) UILabel *course; // 年/万公里
@property (nonatomic, strong) UILabel *price; // 销售价格
@property (nonatomic, strong) UILabel *originalPrice; // 新车价
@property (nonatomic, strong) UILabel *lookCarTime; // 看车时间

@property (nonatomic, strong) YLTableViewModel *tableViewModel;
@property (nonatomic, strong) UIView *line;// 底线

@end

@implementation YLLookCarDetailView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)tapClick:(UITapGestureRecognizer *)sender {
    if (self.lookCarDetailBlock) {
        self.lookCarDetailBlock(self.tableViewModel);
    }
}


- (void)setupUI {
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.backgroundColor = YLColor(233.f, 233.f, 233.f);
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
    originalPrice.textColor = YLColor(155.f, 155.f, 155.f);
    [self addSubview:originalPrice];
    self.originalPrice = originalPrice;
    
    UILabel *price = [[UILabel alloc] init];
    price.textColor = [UIColor redColor];
    price.font = [UIFont systemFontOfSize:18];
    [self addSubview:price];
    self.price = price;
    
    UILabel *lookCarTime = [[UILabel alloc] init];
    lookCarTime.text = @"看车时间:11月11日 17:50";
    lookCarTime.font = [UIFont systemFontOfSize:12];
    lookCarTime.textColor = [UIColor grayColor];
    [self addSubview:lookCarTime];
    self.lookCarTime = lookCarTime;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
    self.line = line;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat width = YLScreenWidth;
    self.icon.frame = CGRectMake(YLLeftMargin, YLTopSpace, 120, 86);
    CGFloat titleX = CGRectGetMaxX(self.icon.frame) + YLLeftMargin;
    CGFloat titleW = width - 120 - 2 * YLLeftMargin - YLTopSpace;
    self.title.frame = CGRectMake(titleX, YLTopSpace, titleW, 34);
    self.lookCarTime.frame = CGRectMake(titleX, CGRectGetMaxY(self.title.frame)+5, titleW, 17);
    self.price.frame = CGRectMake(titleX, CGRectGetMaxY(self.lookCarTime.frame) + 5, titleW/3, 25);
    self.originalPrice.frame = CGRectMake(CGRectGetMaxX(self.price.frame), CGRectGetMaxY(self.lookCarTime.frame) + 9, width - CGRectGetMaxX(self.price.frame) - YLTopSpace, 17);
    self.line.frame = CGRectMake(0, CGRectGetMaxY(self.icon.frame)-1 + YLLeftMargin, width, 1);
    
}

- (void)setModel:(YLLookCarModel *)model {
    _model = model;
    
    self.tableViewModel = [YLTableViewModel mj_objectWithKeyValues:model.detail];
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.detail.displayImg] placeholderImage:nil];
    self.title.text = model.detail.title;
    self.lookCarTime.text = [NSString stringWithFormat:@"看车时间: %@", model.appointTime];
    self.price.text = [self stringToNumber:model.detail.price];
    NSString *str = [NSString stringWithFormat:@"新车价:%@", [self stringToNumber:model.detail.originalPrice]];
    NSDictionary *attri = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attri];
    self.self.originalPrice.attributedText = attriStr;
//    self.originalPrice.text = [NSString stringWithFormat:@"新车价:%@", [self stringToNumber:model.detail.originalPrice]];
}

- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}
@end

//
//  YLBargainHistoryDetailHeader.m
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBargainHistoryDetailHeader.h"
#import "YLCondition.h"


#define YLTopSpace 10

@interface YLBargainHistoryDetailHeader ()

@property (nonatomic, strong) UIImageView *icon; // 图片
@property (nonatomic, strong) UILabel *title; // 名称
@property (nonatomic, strong) UILabel *course; // 年/万公里
@property (nonatomic, strong) UILabel *price; // 销售价格
@property (nonatomic, strong) UILabel *originalPrice; // 新车价
@property (nonatomic, strong) YLCondition *bargainNumber;// 砍价数量

//@property (nonatomic, strong) UIView *line;

@end

@implementation YLBargainHistoryDetailHeader

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(YLLeftMargin, YLTopSpace, 120, 86)];
    icon.backgroundColor = YLColor(233.f, 233.f, 233.f);
    icon.layer.cornerRadius = 5.f;
    icon.layer.masksToBounds = YES;
    [self addSubview:icon];
    self.icon = icon;
    
    CGFloat titleX = CGRectGetMaxX(icon.frame) + YLLeftMargin;
    CGFloat titleW = YLScreenWidth - 120 - 2 * YLLeftMargin - YLTopSpace;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, YLTopSpace, titleW, 34)];
    title.textColor = [UIColor blackColor];
//    title.text = @"嘻嘻嘻嘻嘻嘻嘻";
    title.font = [UIFont systemFontOfSize:14];
    title.numberOfLines = 0;
    [self addSubview:title];
    self.title = title;
    
    UILabel *course = [[UILabel alloc] initWithFrame:CGRectMake(titleX, CGRectGetMaxY(self.title.frame) + 5, titleW, 17)];
    course.textColor = [UIColor blackColor];
    course.font = [UIFont systemFontOfSize:12];
    course.textAlignment = NSTextAlignmentLeft;
//    course.text = @"23万公里/年";
    [self addSubview:course];
    self.course = course;
    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(titleX, CGRectGetMaxY(course.frame) + 5, titleW/3, 25)];
    price.textColor = [UIColor redColor];
    price.font = [UIFont systemFontOfSize:18];
//    price.text = @"20万";
    [self addSubview:price];
    self.price = price;
    
    UILabel *originalPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(price.frame), CGRectGetMaxY(course.frame) + 9, YLScreenWidth - CGRectGetMaxX(price.frame) - YLTopSpace, 17)];
    originalPrice.font = [UIFont systemFontOfSize:12];
    originalPrice.textAlignment = NSTextAlignmentLeft;
//    originalPrice.text = @"新车价:46万";
    [self addSubview:originalPrice];
    self.originalPrice = originalPrice;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame) + YLTopSpace, YLScreenWidth, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
//    self.line = line;
    
    YLCondition *bargainNumber = [YLCondition buttonWithType:UIButtonTypeCustom];
    bargainNumber.type = YLConditionTypeWhite;
    bargainNumber.frame = CGRectMake(YLScreenWidth - 36 - 15, 40, 36, 36);
//    [bargainNumber setTitle:@"10" forState:UIControlStateNormal];
    bargainNumber.layer.cornerRadius = 18.f;
    bargainNumber.layer.masksToBounds = YES;
    [self addSubview:bargainNumber];
    self.bargainNumber = bargainNumber;
}

- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}

- (void)setModel:(YLBargainHistoryModel *)model {
    
    _model = model;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.detail.displayImg] placeholderImage:nil];
    self.title.text = model.detail.title;
    self.course.text = model.detail.course;
    self.price.text = model.detail.price;
    self.originalPrice.text = model.detail.originalPrice;
    [self.bargainNumber setTitle:model.count forState:UIControlStateNormal];
}
@end

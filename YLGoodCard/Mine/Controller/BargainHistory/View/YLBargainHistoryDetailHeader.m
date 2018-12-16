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
//@property (nonatomic, strong) YLCondition *bargainNumber;// 砍价数量
@property (nonatomic, strong) UIView *line;

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
    
    UILabel *price = [[UILabel alloc] init];
    price.textColor = [UIColor redColor];
    price.font = [UIFont systemFontOfSize:18];
    [self addSubview:price];
    self.price = price;
    
    UILabel *originalPrice = [[UILabel alloc] init];
    originalPrice.font = [UIFont systemFontOfSize:12];
    originalPrice.textAlignment = NSTextAlignmentLeft;
    [self addSubview:originalPrice];
    self.originalPrice = originalPrice;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
    self.line = line;
    
//    YLCondition *bargainNumber = [YLCondition buttonWithType:UIButtonTypeCustom];
//    bargainNumber.type = YLConditionTypeWhite;
//    bargainNumber.frame = CGRectMake(YLScreenWidth - 36 - 15, 40, 36, 36);
//    bargainNumber.layer.cornerRadius = 18.f;
//    bargainNumber.layer.masksToBounds = YES;
//    [self addSubview:bargainNumber];
//    self.bargainNumber = bargainNumber;
}

- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}

- (void)setModel:(YLBargainHistoryModel *)model {
    
    _model = model;
    
    self.icon.frame = CGRectMake(YLLeftMargin, YLTopSpace, 120, 86);
    
    CGSize priceSize = [[self stringToNumber:model.detail.price] getSizeWithFont:[UIFont systemFontOfSize:18]];
    CGFloat priceW = priceSize.width + 10;
    CGFloat titleX = CGRectGetMaxX(self.icon.frame) + YLLeftMargin;
    CGFloat titleW = YLScreenWidth - 120 - 2 * YLLeftMargin - YLTopSpace;
    self.title.frame = CGRectMake(titleX, YLTopSpace, titleW, 34);
    self.course.frame = CGRectMake(titleX, CGRectGetMaxY(self.title.frame) + 5, titleW, 17);
    self.price.frame = CGRectMake(titleX, CGRectGetMaxY(self.course.frame) + 5, priceW, 25);
    self.originalPrice.frame = CGRectMake(CGRectGetMaxX(self.price.frame), CGRectGetMaxY(self.course.frame) + 9, YLScreenWidth - CGRectGetMaxX(self.price.frame) - YLTopSpace, 17);
    self.line.frame = CGRectMake(0, CGRectGetMaxY(self.icon.frame) + YLLeftMargin, YLScreenWidth, 1);

    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.detail.displayImg] placeholderImage:nil];
    self.title.text = model.detail.title;
    self.course.text = [NSString stringWithFormat:@"%@万公里/年", model.detail.course];
    self.price.text = [self stringToNumber:model.detail.price];
    self.originalPrice.text = [NSString stringWithFormat:@"新车价:%@", [self stringToNumber:model.detail.originalPrice]];
//    if ([model.count isEqualToString:@"0"]) {
//        self.bargainNumber.hidden = YES;
//    } else {
//        [self.bargainNumber setTitle:model.count forState:UIControlStateNormal];
//    }
}
@end

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
@property (nonatomic, strong) UILabel *line;

@property (nonatomic, strong) YLTableViewModel *tableViewModel;

@end

@implementation YLCommandView

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
    if (self.saleOrderCommandBlock) {
        self.saleOrderCommandBlock(self.tableViewModel);
    }
}

- (void)setupUI {
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.backgroundColor = YLColor(233.f, 233.f, 233.f);
    icon.layer.cornerRadius = 5.f;
    icon.layer.masksToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;
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
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
    self.line = line;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
//    self.icon.frame = CGRectMake(YLLeftMargin, YLTopSpace, 120, 86);
//    float titleX = CGRectGetMaxX(self.icon.frame) + YLLeftMargin;
//    float titleW = YLScreenWidth - 120 - 2 * YLLeftMargin - YLTopSpace;
//    self.title.frame = CGRectMake(titleX, YLTopSpace, titleW, 34);
//    self.course.frame = CGRectMake(titleX, CGRectGetMaxY(self.title.frame) + 5, titleW, 17);
//    self.price.frame = CGRectMake(titleX, CGRectGetMaxY(self.course.frame) + 5, titleW/2, 25);
//    self.originalPrice.frame = CGRectMake(CGRectGetMaxX(self.price.frame), CGRectGetMaxY(self.course.frame) + 9, YLScreenWidth - CGRectGetMaxX(self.price.frame) - YLTopSpace, 17);
}

- (void)setModel:(YLSaleOrderModel *)model {
    _model = model;
    
    self.tableViewModel = [YLTableViewModel mj_objectWithKeyValues:model.detail];
//    NSLog(@"%@", self.tableViewModel);
    
    self.icon.frame = CGRectMake(YLLeftMargin, YLTopSpace, 120, 86);
    CGFloat titleX = CGRectGetMaxX(self.icon.frame) + YLLeftMargin;
    CGFloat titleW = YLScreenWidth - 120 - 2 * YLLeftMargin - YLTopSpace;
    self.title.frame = CGRectMake(titleX, YLTopSpace, titleW, 34);
    self.course.frame = CGRectMake(titleX, CGRectGetMaxY(self.title.frame) + 5, titleW, 17);
    CGSize size = [[self stringToNumber:model.detail.price] getSizeWithFont:[UIFont systemFontOfSize:18]];
    self.price.frame = CGRectMake(titleX, CGRectGetMaxY(self.course.frame) + 5, size.width + 10, 25);
    self.originalPrice.frame = CGRectMake(CGRectGetMaxX(self.price.frame), CGRectGetMaxY(self.course.frame) + 9, YLScreenWidth - CGRectGetMaxX(self.price.frame) - YLTopSpace, 17);
    self.line.frame = CGRectMake(0, CGRectGetMaxY(self.icon.frame) + YLLeftMargin, YLScreenWidth, 1);
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.detail.displayImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.title.text = model.detail.title;
    self.price.text = [self stringToNumber:model.detail.price];
    NSString *str = [NSString stringWithFormat:@"新车价%@", [self stringToNumber:model.detail.originalPrice]];
    NSDictionary *attri = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attri];
    self.self.originalPrice.attributedText = attriStr;
//    self.originalPrice.text = [NSString stringWithFormat:@"新车价%@", [self stringToNumber:model.detail.originalPrice]];
    self.course.text = [NSString stringWithFormat:@"%@万公里/年", model.detail.course];
}

- (NSString *)stringToNumber:(NSString *)number {
    
    CGFloat count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}

@end

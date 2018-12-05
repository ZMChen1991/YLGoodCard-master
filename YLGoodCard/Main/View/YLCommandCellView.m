//
//  YLCommandCellView.m
//  YLYouka
//
//  Created by lm on 2018/11/14.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCommandCellView.h"

#define YLLeftSpace 15
#define YLTopSpace 12


@interface YLCommandCellView ()

@property (nonatomic, strong) UIImageView *icon; // 图片
@property (nonatomic, strong) UILabel *title; // 名称
@property (nonatomic, strong) UILabel *course; // 年/万公里
@property (nonatomic, strong) UILabel *price; // 销售价格
@property (nonatomic, strong) UILabel *originalPrice; // 新车价
@property (nonatomic, strong) UIImageView *downIcon;// 向下箭头
@property (nonatomic, strong) UILabel *downTitle;// 降价信息
@property (nonatomic, strong) UIButton *bargain;// 砍价数量

@property (nonatomic, strong) UIView *line;// 底线



@end

@implementation YLCommandCellView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        self.isSmallImage = NO;
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
    
    UIImageView *downIcon = [[UIImageView alloc] init];
    downIcon.backgroundColor = [UIColor blueColor];
    [self addSubview:downIcon];
    self.downIcon = downIcon;
    
    UILabel *downTitle = [[UILabel alloc] init];
    downTitle.textColor = [UIColor redColor];
    downTitle.font = [UIFont systemFontOfSize:12];
    downTitle.textColor = [UIColor grayColor];
    downTitle.backgroundColor = [UIColor yellowColor];
    [self addSubview:downTitle];
    self.downTitle = downTitle;
    
    UIButton *bargain = [UIButton buttonWithType:UIButtonTypeCustom];
    bargain.layer.cornerRadius = 18;
    bargain.layer.masksToBounds = YES;
    bargain.backgroundColor = [UIColor greenColor];
    [self addSubview:bargain];
    self.bargain = bargain;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    self.line = line;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    float width = self.frame.size.width;
    
    if (!self.isSmallImage) { // 大图模式
        self.icon.frame = CGRectMake(YLLeftSpace, YLLeftSpace, width - 2 * YLLeftSpace, 228);
        self.title.frame = CGRectMake(YLLeftSpace, CGRectGetMaxY(self.icon.frame)+YLLeftSpace, width - 2* YLLeftSpace, 17);
        self.course.frame = CGRectMake(YLLeftSpace, CGRectGetMaxY(self.title.frame) + 5, width - 2* YLLeftSpace, 17);
        self.price.frame = CGRectMake(YLLeftSpace, CGRectGetMaxY(self.course.frame) + 5, (width - 2* YLLeftSpace) / 2, 25);
        self.originalPrice.frame = CGRectMake(CGRectGetMaxX(self.price.frame) + 5, CGRectGetMaxY(self.course.frame) + 5, (width - 2* YLLeftSpace) / 2, 25);
        self.line.frame = CGRectMake(0, CGRectGetMaxY(self.price.frame)+YLTopSpace-1, width, 1);
    } else {// 小图模式
        self.icon.frame = CGRectMake(YLLeftSpace, YLTopSpace, 120, 86);
        float titleX = CGRectGetMaxX(self.icon.frame) + YLLeftSpace;
        float titleW = width - 120 - 2 * YLLeftSpace - YLTopSpace;
        self.title.frame = CGRectMake(titleX, YLTopSpace, titleW, 34);
        self.course.frame = CGRectMake(titleX, CGRectGetMaxY(self.title.frame) + 5, titleW, 17);
        self.price.frame = CGRectMake(titleX, CGRectGetMaxY(self.course.frame) + 5, titleW/3, 25);
        self.line.frame = CGRectMake(0, CGRectGetMaxY(self.icon.frame)+YLTopSpace-1, width, 1);
        switch (self.model.cellStatus) {
            case YLTableViewCellStatusSold:
                self.originalPrice.frame = CGRectMake(CGRectGetMaxX(self.price.frame), CGRectGetMaxY(self.course.frame) + 5, titleW / 2, 25);
                break;
            case YLTableViewCellStatusBargain:
                self.originalPrice.frame = CGRectMake(CGRectGetMaxX(self.price.frame), CGRectGetMaxY(self.course.frame) + 5, titleW / 2, 25);
                float bargainX = width - 36 - YLLeftSpace;
                float bargainY = 110 - 36 - YLLeftSpace;
                self.bargain.frame = CGRectMake(bargainX, bargainY, 36, 36);
                break;
            case YLTableViewCellStatusDownPrice:
                self.downIcon.frame = CGRectMake(CGRectGetMaxX(self.price.frame) + 5, CGRectGetMaxY(self.course.frame) + 13, 14, 14);
                self.downTitle.frame = CGRectMake(CGRectGetMaxX(self.downIcon.frame) + 5, CGRectGetMaxY(self.course.frame) + 10, titleW / 2, 17);
                break;
            default:
                break;
        }
    }
}

- (void)setModel:(YLTableViewModel *)model {
    
    _model = model;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.displayImg] placeholderImage:nil];
    self.title.text = model.title;
    NSString *course = [NSString stringWithFormat:@"%@年/万公里",model.course];
    self.course.text = course;
    self.price.text = [self stringToNumber:model.price];
    NSString *string =[self stringToNumber:model.originalPrice];
    self.originalPrice.text = [NSString stringWithFormat:@"新车价%@", string];
    self.downTitle.text = model.downPrice;
    [self.bargain setTitle:model.bargain forState:UIControlStateNormal];
}

- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}

@end

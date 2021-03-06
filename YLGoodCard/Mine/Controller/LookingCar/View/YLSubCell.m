//
//  YLSubCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/29.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSubCell.h"

#define YLLeftSpace 15
#define YLTopSpace 12


@interface YLSubCell ()

@property (nonatomic, strong) UIImageView *icon; // 图片
@property (nonatomic, strong) UILabel *title; // 名称
@property (nonatomic, strong) UILabel *course; // 年/万公里
@property (nonatomic, strong) UILabel *price; // 销售价格
@property (nonatomic, strong) UILabel *originalPrice; // 新车价
@property (nonatomic, strong) UILabel *lookCarTime; // 看车时间

@property (nonatomic, strong) UIView *line;// 底线

@end

@implementation YLSubCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"YLSubCell";
    YLSubCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLSubCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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

- (void)setModel:(YLSubCellModel *)model {
    
    _model = model;
    self.icon.frame = model.iconF;
    self.title.frame = model.titleF;
//    self.course.frame = model.courseF;
    self.price.frame = model.priceF;
    self.originalPrice.frame = model.originalPriceF;
    self.lookCarTime.frame = model.lookCarTimeF;
    self.line.frame = model.lineF;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.lookCarModel.detail.displayImg] placeholderImage:nil];
    self.title.text = model.lookCarModel.detail.title;
//    self.course.text = [NSString stringWithFormat:@"%@万公里/年",model.lookCarModel.detail.course];
    self.price.text = [self stringToNumber:model.lookCarModel.detail.price];
    NSString *str = [NSString stringWithFormat:@"新车价:%@", [self stringToNumber:model.lookCarModel.detail.originalPrice]];
    NSDictionary *attri = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attri];
    self.self.originalPrice.attributedText = attriStr;
//    self.originalPrice.text = [NSString stringWithFormat:@"新车价:%@", [self stringToNumber:model.lookCarModel.detail.originalPrice]];
    
    if ([model.lookCarModel.detail.status isEqualToString:@"3"]) {
        self.lookCarTime.text = [NSString stringWithFormat:@"看车时间:%@", model.lookCarModel.appointTime];
    } else {
        self.lookCarTime.text = [NSString stringWithFormat:@"看车时间已取消，车辆已下架"];
    }
    
    
}

- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}
@end

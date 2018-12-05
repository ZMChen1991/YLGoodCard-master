//
//  YLBuyTableViewCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/22.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBuyTableViewCell.h"

#define YLLeftSpace 15
#define YLTopSpace 12


@interface YLBuyTableViewCell ()

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

@implementation YLBuyTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"YLBuyTableViewCell";
    YLBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLBuyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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

- (void)setCellFrame:(YLBuyCellFrame *)cellFrame {
    
    _cellFrame = cellFrame;
    self.icon.frame = cellFrame.iconF;
    self.title.frame = cellFrame.titleF;
    self.course.frame = cellFrame.courseF;
    self.price.frame = cellFrame.priceF;
    self.originalPrice.frame = cellFrame.originalPriceF;
    self.downIcon.frame = cellFrame.downIconF;
    self.downTitle.frame = cellFrame.downTitleF;
    self.bargain.frame = cellFrame.bargainF;
    self.line.frame = cellFrame.lineF;
    
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:cellFrame.model.displayImg] placeholderImage:nil];
    self.title.text = cellFrame.model.title;
    NSString *course = [NSString stringWithFormat:@"%@年/万公里",cellFrame.model.course];
    self.course.text = course;
    self.price.text = [self stringToNumber:cellFrame.model.price];
    NSString *originalPrice =[self stringToNumber:cellFrame.model.originalPrice];
    self.originalPrice.text = [NSString stringWithFormat:@"新车价%@", originalPrice];
    self.downTitle.text = cellFrame.model.downPrice;
    [self.bargain setTitle:cellFrame.model.bargain forState:UIControlStateNormal];
}

- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}
@end

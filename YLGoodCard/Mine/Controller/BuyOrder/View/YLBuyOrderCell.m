//
//  YLBuyOrderCell.m
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBuyOrderCell.h"

@interface YLBuyOrderCell ()

@property (nonatomic, strong) UIImageView *icon; // 图片
@property (nonatomic, strong) UILabel *title; // 名称
@property (nonatomic, strong) UILabel *course; // 年/万公里
@property (nonatomic, strong) UILabel *price; // 销售价格
@property (nonatomic, strong) UILabel *originalPrice; // 新车价
@property (nonatomic, strong) UILabel *lookCarTime; // 看车时间

@property (nonatomic, strong) UIView *line;// 底线

@end

@implementation YLBuyOrderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"YLBuyOrderCell";
    YLBuyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLBuyOrderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    
    //    UILabel *lookCarTime = [[UILabel alloc] init];
    //    lookCarTime.text = @"看车时间:11月11日 17:50";
    //    lookCarTime.font = [UIFont systemFontOfSize:12];
    //    lookCarTime.textColor = [UIColor grayColor];
    //    [self addSubview:lookCarTime];
    //    self.lookCarTime = lookCarTime;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    self.line = line;
}

- (void)setBuyOrderCellFrame:(YLBuyOrderCellFrame *)buyOrderCellFrame {
    _buyOrderCellFrame = buyOrderCellFrame;
    
    self.icon.frame = buyOrderCellFrame.iconF;
    self.title.frame = buyOrderCellFrame.titleF;
    self.price.frame = buyOrderCellFrame.priceF;
    self.course.frame = buyOrderCellFrame.courseF;
    self.originalPrice.frame = buyOrderCellFrame.originalPriceF;
    self.line.frame = buyOrderCellFrame.lineF;
    
    //  赋值
    //    [self.icon sd_setImageWithURL:[NSURL URLWithString:saleOrderCellFrame.model.detail] placeholderImage:nil];
    self.title.text = @"xxxxx";
    self.price.text = @"12.9万";
    self.course.text = @"25万公里/年";
    self.originalPrice.text = @"新车含税价25.6万";
}


- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}
@end

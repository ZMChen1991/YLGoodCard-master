//
//  YLCollectCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCollectCell.h"

@interface YLCollectCell ()

@property (nonatomic, strong) UIImageView *icon; // 图片
@property (nonatomic, strong) UILabel *title; // 名称
@property (nonatomic, strong) UILabel *course; // 年/万公里
@property (nonatomic, strong) UILabel *price; // 销售价格
@property (nonatomic, strong) UILabel *originalPrice; // 新车价

@property (nonatomic, strong) UIView *line;// 底线

@end

@implementation YLCollectCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"YLSubCell";
    YLCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLCollectCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    self.line = line;
}

- (void)setCollectCellFrame:(YLCollectCellFrame *)collectCellFrame {
    
    _collectCellFrame = collectCellFrame;
    
    self.icon.frame = collectCellFrame.iconF;
    self.title.frame = collectCellFrame.titleF;
    self.course.frame = collectCellFrame.courseF;
    self.price.frame = collectCellFrame.priceF;
    self.originalPrice.frame = collectCellFrame.originalPriceF;
    self.line.frame = collectCellFrame.lineF;

    [self.icon sd_setImageWithURL:[NSURL URLWithString:collectCellFrame.collectionModel.detail.displayImg] placeholderImage:nil];
    self.title.text = collectCellFrame.collectionModel.detail.title;
    self.course.text = [NSString stringWithFormat:@"%@万公里/年",collectCellFrame.collectionModel.detail.course];
    self.price.text = [self stringToNumber:collectCellFrame.collectionModel.detail.price];
    self.originalPrice.text = [NSString stringWithFormat:@"新车价:%@", [self stringToNumber:collectCellFrame.collectionModel.detail.originalPrice]];
    
}

- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}

@end

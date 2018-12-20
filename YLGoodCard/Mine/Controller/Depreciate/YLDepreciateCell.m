//
//  YLDepreciateCell.m
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDepreciateCell.h"

@interface YLDepreciateCell ()

@property (nonatomic, strong) UIImageView *icon; // 图片
@property (nonatomic, strong) UILabel *title; // 名称
@property (nonatomic, strong) UILabel *course; // 年/万公里
@property (nonatomic, strong) UILabel *price; // 销售价格
@property (nonatomic, strong) UILabel *originalPrice; // 新车价
@property (nonatomic, strong) UILabel *depreciate; // 降价
@property (nonatomic, strong) UIImageView *down;// 下降

@property (nonatomic, strong) UIView *line;

@end

@implementation YLDepreciateCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"YLSaleOrderCell";
    YLDepreciateCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLDepreciateCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    
    UILabel *price = [[UILabel alloc] init];
    price.textColor = [UIColor redColor];
    price.font = [UIFont systemFontOfSize:18];
    [self addSubview:price];
    self.price = price;
    
    UIImageView *down = [[UIImageView alloc] init];
    down.layer.cornerRadius = 8.f;
    down.layer.masksToBounds = YES;
    [self addSubview:down];
    self.down = down;
    
    UILabel *depreciate = [[UILabel alloc] init];
//    depreciate.text = @"比原价下降了2.8万";
    depreciate.font = [UIFont systemFontOfSize:12];
    depreciate.textColor = YLColor(155.f, 155.f, 155.f);
    [self addSubview:depreciate];
    self.depreciate = depreciate;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
    self.line = line;
}

- (void)setCellFrame:(YLDepreciateCellFrame *)cellFrame {
    _cellFrame = cellFrame;
    self.icon.frame = cellFrame.iconF;
    self.title.frame = cellFrame.titleF;
    self.price.frame = cellFrame.priceF;
    self.course.frame = cellFrame.courseF;
    self.line.frame = cellFrame.lineF;
    self.depreciate.frame = cellFrame.depreciateF;
    self.down.frame = cellFrame.downF;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:cellFrame.model.detail.displayImg] placeholderImage:nil];
    self.title.text = cellFrame.model.detail.title;
    self.price.text = [self stringToNumber:cellFrame.model.detail.price];
    self.course.text = [NSString stringWithFormat:@"%@万公里/年", cellFrame.model.detail.course];
    self.depreciate.text = [NSString stringWithFormat:@"比原价下降了%@", [self stringToNumber:cellFrame.model.priceSpread]];
    self.down.image = [UIImage imageNamed:@"下降"];
}

- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}
@end

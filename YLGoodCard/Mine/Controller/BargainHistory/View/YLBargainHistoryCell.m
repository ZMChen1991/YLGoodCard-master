//
//  YLBargainHistoryCell.m
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBargainHistoryCell.h"
#import "YLCondition.h"

@interface YLBargainHistoryCell ()

@property (nonatomic, strong) UIImageView *icon; // 图片
@property (nonatomic, strong) UILabel *title; // 名称
@property (nonatomic, strong) UILabel *course; // 年/万公里
@property (nonatomic, strong) UILabel *price; // 销售价格
@property (nonatomic, strong) UILabel *originalPrice; // 新车价
@property (nonatomic, strong) YLCondition *bargainNumber;// 砍价数量
@property (nonatomic, strong) UILabel *message;

@property (nonatomic, strong) UIView *line;

@end

@implementation YLBargainHistoryCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"YLBargainHistoryCell";
    YLBargainHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLBargainHistoryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    originalPrice.textColor = YLColor(155.f, 155.f, 155.f);
    originalPrice.textAlignment = NSTextAlignmentLeft;
    [self addSubview:originalPrice];
    self.originalPrice = originalPrice;
    
    UILabel *price = [[UILabel alloc] init];
    price.textColor = [UIColor redColor];
    price.font = [UIFont systemFontOfSize:18];
    [self addSubview:price];
    self.price = price;
    
    UILabel *message = [[UILabel alloc] init];
    message.textColor = YLColor(155.f, 155.f, 155.f);
    message.font = [UIFont systemFontOfSize:12];
//    message.backgroundColor = [UIColor redColor];
    [self addSubview:message];
    self.message = message;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
    self.line = line;
    
    YLCondition *bargainNumber = [YLCondition buttonWithType:UIButtonTypeCustom];
    bargainNumber.type = YLConditionTypeWhite;
    [bargainNumber setTitle:@"10" forState:UIControlStateNormal];
    bargainNumber.layer.cornerRadius = 18.f;
    bargainNumber.layer.masksToBounds = YES;
    [self addSubview:bargainNumber];
    self.bargainNumber = bargainNumber;
}

- (void)setCellFrame:(YLBargainHistoryCellFrame *)cellFrame {
    _cellFrame = cellFrame;
    
    self.icon.frame = cellFrame.iconF;
    self.title.frame = cellFrame.titleF;
    self.price.frame = cellFrame.priceF;
    self.course.frame = cellFrame.courseF;
    self.originalPrice.frame = cellFrame.originalPriceF;
    self.message.frame = cellFrame.messageF;
    self.bargainNumber.frame = cellFrame.bargainNumberF;
    self.line.frame = cellFrame.lineF;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:cellFrame.model.detail.displayImg] placeholderImage:nil];
    self.title.text = cellFrame.model.detail.title;
    self.price.text = [self stringToNumber:cellFrame.model.detail.price];
    self.course.text = [NSString stringWithFormat:@"%@万公里/年", cellFrame.model.detail.course];
    self.originalPrice.text = [NSString stringWithFormat:@"新车价%@", [self stringToNumber:cellFrame.model.detail.originalPrice]];
    if ([cellFrame.model.count isEqualToString:@"0"]) {
        self.bargainNumber.hidden = YES;
    } else {
        [self.bargainNumber setTitle:cellFrame.model.count forState:UIControlStateNormal];
    }
    
    if ([cellFrame.model.mark isEqualToString:@"2"]) {
        self.message.text = [NSString stringWithFormat:@"卖家还价:%@,等待您的处理", [self stringToNumber:cellFrame.model.price]];
    } else {
        self.message.text = [NSString stringWithFormat:@"您的报价:%@,等待卖家的处理", [self stringToNumber:cellFrame.model.price]];
    }
    
}


- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}
@end

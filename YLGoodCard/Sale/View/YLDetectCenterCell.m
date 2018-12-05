//
//  YLDetectCenterCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetectCenterCell.h"

@interface YLDetectCenterCell ()

@property (nonatomic, strong) UILabel *centerL;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *telephone;

@end

@implementation YLDetectCenterCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"YLDetectCenterCell";
    YLDetectCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLDetectCenterCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    
    NSInteger width = self.frame.size.width;
    UILabel *center = [[UILabel alloc] init];
    center.frame = CGRectMake(YLLeftMargin, YLLeftMargin, width - 2 * YLLeftMargin, 22);
//    center.text = @"优卡检测中心";
    center.font = [UIFont systemFontOfSize:16];
    [self addSubview:center];
    self.centerL = center;
    
    UILabel *address = [[UILabel alloc] init];
    address.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(center.frame) + 5, width - 2 * YLLeftMargin, 20);
//    address.text = @"地址:阳江市江城区金山路118号";
    address.font = [UIFont systemFontOfSize:14];
    [self addSubview:address];
    self.address = address;
    
    UILabel *telephone = [[UILabel alloc] init];
    telephone.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(address.frame), width - 2 * YLLeftMargin, 20);
//    telephone.text = @"电话:0662-88888888";
    telephone.font = [UIFont systemFontOfSize:14];
    [self addSubview:telephone];
    self.telephone = telephone;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(telephone.frame) + YLLeftMargin - 1, width, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
}

- (void)setModel:(YLDetectCenterModel *)model {
    
    _model = model;
    self.centerL.text = model.name;
    self.address.text = [NSString stringWithFormat:@"地址:%@", model.address];
    self.telephone.text = [NSString stringWithFormat:@"电话:%@", model.phone];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

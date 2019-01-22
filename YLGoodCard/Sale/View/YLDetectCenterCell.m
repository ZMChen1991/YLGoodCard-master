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
@property (nonatomic, strong) UIView *line;

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
    
//    NSInteger width = self.frame.size.width;
    UILabel *center = [[UILabel alloc] init];
//    center.frame = CGRectMake(YLLeftMargin, YLLeftMargin, width - 2 * YLLeftMargin, 22);
//    center.text = @"优卡检测中心";
    center.font = [UIFont systemFontOfSize:16];
    center.textColor = [UIColor blackColor];
    [self addSubview:center];
    self.centerL = center;
    
    UILabel *address = [[UILabel alloc] init];
//    address.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(center.frame) + 5, width - 2 * YLLeftMargin, 20);
//    address.text = @"地址:阳江市江城区金山路118号";
    address.font = [UIFont systemFontOfSize:14];
    address.numberOfLines = 0;
    address.textColor = YLColor(51.f, 51.f, 51.f);
    [self addSubview:address];
    self.address = address;
    
    UILabel *telephone = [[UILabel alloc] init];
//    telephone.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(address.frame), width - 2 * YLLeftMargin, 20);
//    telephone.text = @"电话:0662-88888888";
    telephone.font = [UIFont systemFontOfSize:14];
    telephone.textColor = YLColor(51.f, 51.f, 51.f);
    [self addSubview:telephone];
    self.telephone = telephone;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
    self.line = line;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
}


- (void)setCellFrame:(YLDetectCenterCellFrame *)cellFrame {
    _cellFrame = cellFrame;
    self.centerL.frame = cellFrame.centerF;
    self.address.frame = cellFrame.addressF;
    self.telephone.frame = cellFrame.telephoneF;
    self.line.frame = cellFrame.lineF;
    
    self.centerL.text = cellFrame.model.name;
    self.address.text = [NSString stringWithFormat:@"地址:%@", cellFrame.model.address];
    self.telephone.text = [NSString stringWithFormat:@"电话:%@", cellFrame.model.phone];
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

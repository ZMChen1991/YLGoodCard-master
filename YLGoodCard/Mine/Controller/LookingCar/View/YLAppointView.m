//
//  YLAppointView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLAppointView.h"

@interface YLAppointView ()

@property (nonatomic, strong) UILabel *centerName;
@property (nonatomic, strong) UILabel *telephone;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *timeL;
@end

@implementation YLAppointView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
        self.layer.cornerRadius = 5.f;
        self.layer.masksToBounds = YES;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CGFloat labelW = YLScreenWidth - 2 * YLLeftMargin;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, 2 * YLLeftMargin, labelW - 2 * YLLeftMargin, 22)];
    title.text = @"预约信息";
    title.font = [UIFont systemFontOfSize:22];
    title.textAlignment = NSTextAlignmentLeft;
    [self addSubview:title];
    
    UILabel *centerName = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(title.frame) + YLLeftMargin, labelW - 2 * YLLeftMargin, 22)];
    centerName.font = [UIFont systemFontOfSize:14];
    centerName.textAlignment = NSTextAlignmentLeft;
//    centerName.backgroundColor = [UIColor redColor];
    [self addSubview:centerName];
    self.centerName = centerName;
    
    UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(centerName.frame) + 5, labelW - 2 * YLLeftMargin, 22)];
    address.font = [UIFont systemFontOfSize:14];
    address.textAlignment = NSTextAlignmentLeft;
//    address.backgroundColor = [UIColor redColor];
    [self addSubview:address];
    self.address = address;
    
    UILabel *telephone = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(address.frame) + 5, labelW - 2 * YLLeftMargin, 22)];
    telephone.font = [UIFont systemFontOfSize:14];
    telephone.textAlignment = NSTextAlignmentLeft;
//    telephone.backgroundColor = [UIColor redColor];
    [self addSubview:telephone];
    self.telephone = telephone;
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(telephone.frame) + 5, labelW - 2 * YLLeftMargin, 22)];
    time.font = [UIFont systemFontOfSize:14];
    time.textAlignment = NSTextAlignmentLeft;
//    time.backgroundColor = [UIColor redColor];
    [self addSubview:time];
    self.timeL = time;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

- (void)setModel:(YLDetectCenterModel *)model {
    
    _model = model;
    self.centerName.text = [NSString stringWithFormat:@"预约中心: %@", model.name];
    self.address.text = [NSString stringWithFormat:@"中心地址: %@",  model.address];
    self.telephone.text = [NSString stringWithFormat:@"联系电话: %@", model.phone];
    self.timeL.text = [NSString stringWithFormat:@"看车时间: %@", self.time];
    
}

@end

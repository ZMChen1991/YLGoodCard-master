//
//  YLMineIcon.m
//  YLGoodCard
//
//  Created by lm on 2018/11/21.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLMineIcon.h"

@interface YLMineIcon ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;

@end

@implementation YLMineIcon
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"评估师"];
    [self addSubview:icon];
    self.icon = icon;
    
    UILabel *name = [[UILabel alloc] init];
    name.text = @"13800138000";
    name.font = [UIFont systemFontOfSize:16];
    name.textColor = [UIColor whiteColor];
    name.textAlignment = NSTextAlignmentLeft;
    [self addSubview:name];
    self.name = name;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.icon.frame = CGRectMake(YLLeftMargin, YLLeftMargin, 60, 60);
    self.name.frame = CGRectMake(CGRectGetMaxX(self.icon.frame) + YLLeftMargin, 22, 200, 25);
}

- (void)setTelephone:(NSString *)telephone {
    
    _telephone = telephone;
    self.name.text = telephone;
}

@end

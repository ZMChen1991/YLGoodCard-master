//
//  YLLoginHeader.m
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLLoginHeader.h"
#import "YLCondition.h"

@interface YLLoginHeader ()

@property (nonatomic, strong) UIImageView *icon;// 头像
@property (nonatomic, strong) YLCondition *loginBtn;// 登录按钮
@property (nonatomic, strong) UILabel *detailTitle;// 登录详情


@end

@implementation YLLoginHeader

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.icon = [[UIImageView alloc] init];
    self.icon.image = [UIImage imageNamed:@"评估师"];
    [self addSubview:self.icon];
    self.loginBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    self.loginBtn.type = YLConditionTypeBlue;
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.loginBtn];
    
    self.detailTitle = [[UILabel alloc] init];
    self.detailTitle.font = [UIFont systemFontOfSize:14];
    self.detailTitle.textAlignment = NSTextAlignmentLeft;
    self.detailTitle.text = @"登录后可查看更多车辆信息";
    self.detailTitle.textColor = [UIColor whiteColor];
    [self addSubview:self.detailTitle];

}

- (void)login {
    
    NSLog(@"点击了登录按钮--需要跳转登录界面");
    if (self.delegate && [self.delegate respondsToSelector:@selector(skipToLogin)]) {
        [self.delegate skipToLogin];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.icon.frame = CGRectMake(YLLeftMargin, YLLeftMargin, 60, 60);
    self.loginBtn.frame = CGRectMake(CGRectGetMaxX(self.icon.frame) + YLLeftMargin, 22, 75, 25);
    self.detailTitle.frame = CGRectMake(CGRectGetMaxX(self.icon.frame) + YLLeftMargin, CGRectGetMaxY(self.loginBtn.frame), 200, 20);
}

@end

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
@property (nonatomic, strong) UIButton *loginBtn;// 登录按钮
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
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.loginBtn.type = YLConditionTypeBlue;
    self.loginBtn.backgroundColor = [UIColor clearColor];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.loginBtn];
    
    self.detailTitle = [[UILabel alloc] init];
    self.detailTitle.font = [UIFont systemFontOfSize:14];
    self.detailTitle.textAlignment = NSTextAlignmentLeft;
    self.detailTitle.text = @"登录后可查看更多车辆信息";
    self.detailTitle.textColor = [UIColor whiteColor];
    [self addSubview:self.detailTitle];

    CGRect rect = CGRectMake(0, 0, YLScreenWidth, 96);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [self graphicsImageWithSize:rect.size];
    [self insertSubview:imageView atIndex:0];
}

// 返回一个渐变色图片
- (UIImage *)graphicsImageWithSize:(CGSize)size {
    CGGradientRef gradient;// 颜色的空间
    size_t num_locations = 2;// 渐变中使用的颜色数
    CGFloat locations[] = {0.0, 1.0}; // 指定每个颜色在渐变色中的位置，值介于0.0-1.0之间, 0.0表示最开始的位置，1.0表示渐变结束的位置
    CGFloat colors[] = {
        13.0/255.0, 196.f/255.f, 255.f/255, 1.0,
        3.0/255.0, 141.f/255.f, 255.f/255, 1.0,
    }; // 指定渐变的开始颜色，终止颜色，以及过度色（如果有的话）
    gradient = CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(), colors, locations, num_locations);
    CGPoint startPoint = CGPointMake(0.0, 0.0);
    CGPoint endPoint = CGPointMake(self.frame.size.width, 1.0);
    //    CGSize size = CGSizeMake(self.view.frame.size.width, 1.0);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"%f-%f", image.size.width, image.size.height);
    return image;
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

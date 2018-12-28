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
    name.text = @"13800000000";
    name.font = [UIFont systemFontOfSize:16];
    name.textColor = [UIColor whiteColor];
    name.textAlignment = NSTextAlignmentLeft;
    [self addSubview:name];
    self.name = name;
    
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

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.icon.frame = CGRectMake(YLLeftMargin, YLLeftMargin, 60, 60);
    self.name.frame = CGRectMake(CGRectGetMaxX(self.icon.frame) + YLLeftMargin, 30, 200, 25);
}

- (void)setTelephone:(NSString *)telephone {
    
    _telephone = telephone;
    self.name.text = telephone;
}

@end

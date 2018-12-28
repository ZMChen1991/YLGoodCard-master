//
//  UIImage+Extension.m
//  (仿)新浪-微博
//
//  Created by lm on 16/2/14.
//  Copyright (c) 2016年 lm. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithName:(NSString *)name
{
    UIImage *image = nil;
    if (iOS7) { // 处理iOS7的情况
        NSString *newName = [name stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:newName];
    }
    
    if (image == nil) {
        image = [UIImage imageNamed:name];
    }
    return image;
}

+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect =CGRectMake(0, 0, 1.0f, 1.0f);
    // 开始位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 开启上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(ref, color.CGColor);
    // 渲染上下文
    CGContextFillRect(ref, rect);
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return image;
}

/**
 返回渐变色图片

 @param colors 颜色数组
 @param startPoint 开始点
 @param endPoint 结束点
 @param size 图片大小
 @return 渐变色图片
 */
+ (UIImage *)imageWithGradientColor:(CGFloat)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size {
    CGGradientRef gradient;// 颜色的空间
    size_t num_locations = 2;// 渐变中使用的颜色数
    CGFloat locations[] = {0.0, 1.0}; // 指定每个颜色在渐变色中的位置，值介于0.0-1.0之间, 0.0表示最开始的位置，1.0表示渐变结束的位置
//    CGFloat colors[] = {
//        13.0/255.0, 196.f/255.f, 255.f/255, 1.0,
//        3.0/255.0, 141.f/255.f, 255.f/255, 1.0,
//    }; // 指定渐变的开始颜色，终止颜色，以及过度色（如果有的话）
    gradient = CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(), &colors, locations, num_locations);
//    CGPoint startPoint = CGPointMake(0.0, 0.0);
//    CGPoint endPoint = CGPointMake(self.view.frame.size.width, 64.0);
//    CGSize size = CGSizeMake(self.view.frame.size.width, 64.0);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

//
//  UIImage+Extension.h
//  (仿)新浪-微博
//
//  Created by lm on 16/2/14.
//  Copyright (c) 2016年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;

+ (UIImage *)imageWithName:(NSString *)name;

// 颜色转换成图片的方法
+ (UIImage *)imageWithColor:(UIColor *)color;

@end

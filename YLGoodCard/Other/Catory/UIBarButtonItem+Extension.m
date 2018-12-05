//
//  UIBarButtonItem+Extension.m
//  YLGoodCard
//
//  Created by lm on 2018/11/20.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateSelected];
    // 设置尺寸
    CGSize size = CGSizeMake(50, 30);
    btn.size = size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end

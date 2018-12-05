//
//  UITextView+Extension.h
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

// 系统版本
#define YLVersion [[[UIDevice currentDevice] systemVersion] floatValue]

@interface UITextView (Extension)

- (void)setPlaceholder:(NSString *)placeholder placeholdColor:(UIColor *)placeholdColor;



@end

//
//  NSString+Extension.m
//  YLGoodCard
//
//  Created by lm on 2018/11/8.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)getSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)getSizeWithFont:(UIFont *)font {
    
    return [self getSizeWithFont:font maxWidth:MAXFLOAT];
}


- (NSMutableAttributedString *)changeString:(NSString *)changeString color:(UIColor *)color {
    
    // 获取字符串
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc] initWithString:self];
    // 找出特定字符串在整个字符串中的位置
    NSRange range = NSMakeRange([[contentStr string] rangeOfString:changeString].location, [[contentStr string] rangeOfString:changeString].length);
    // 修改特定字符的颜色
    [contentStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return contentStr;
}

// 判断字符串是否为空或者空格符
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSString *)stringByDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}


@end

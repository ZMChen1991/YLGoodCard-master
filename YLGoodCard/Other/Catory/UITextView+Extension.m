//
//  UITextView+Extension.m
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

- (void)setPlaceholder:(NSString *)placeholderStr placeholdColor:(UIColor *)placeholdColor {
    
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.text = placeholderStr;
    placeholderLabel.numberOfLines = 0;
    placeholderLabel.textColor = placeholdColor;
    placeholderLabel.font = self.font;
    [placeholderLabel sizeToFit];
    
    if (YLVersion >= 8.3) {
        UILabel *placeholder = [self valueForKey:@"_placeholderLabel"];
        // 防止重复
        if (placeholder) {
            return;
        }
        [self addSubview:placeholderLabel];
        [self setValue:placeholderLabel forKey:@"_placeholderLabel"];
    }
}

@end

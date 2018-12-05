//
//  UIBarButtonItem+Extension.h
//  YLGoodCard
//
//  Created by lm on 2018/11/20.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end

NS_ASSUME_NONNULL_END

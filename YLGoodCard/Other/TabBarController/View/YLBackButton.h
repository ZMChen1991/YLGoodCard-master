//
//  YLBackButton.h
//  Block
//
//  Created by lm on 2018/12/21.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^YLBackBlock)(void);
@interface YLBackButton : UIView

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, copy) YLBackBlock backBlock;

@end

NS_ASSUME_NONNULL_END

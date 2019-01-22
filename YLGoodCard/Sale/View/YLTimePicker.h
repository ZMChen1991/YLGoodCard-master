//
//  YLTimePicker.h
//  YLFunction
//
//  Created by lm on 2019/1/21.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CancelBlock)(void);
typedef void(^SureBlock)(NSString *time);

@interface YLTimePicker : UIView

@property (nonatomic, copy) CancelBlock cancelBlock;
@property (nonatomic, copy) SureBlock sureBlock;

@end

NS_ASSUME_NONNULL_END

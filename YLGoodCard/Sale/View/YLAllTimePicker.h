//
//  YLAllTimePicker.h
//  YLGoodCard
//
//  Created by lm on 2018/12/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLAllTimePicker : UIView
// 返回选择的时间字符串
//typedef void(^TimePickerBlock)(NSString *time);
typedef void(^CancelBlock)(void);
typedef void(^SureBlock)(NSString *checkOut);

//@property (nonatomic, copy) TimePickerBlock timePickerBlock;
@property (nonatomic, copy) CancelBlock cancelBlock;
@property (nonatomic, copy) SureBlock sureBlock;

@end

NS_ASSUME_NONNULL_END

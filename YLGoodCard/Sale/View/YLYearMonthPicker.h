//
//  YLYearMonthPicker.h
//  YLYouka
//
//  Created by lm on 2018/12/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//typedef void(^YearMonthBlock)(NSString *yearMonth);
typedef void(^CancelBlock)(void);
typedef void(^SureBlock)(NSString *licenseTime);


@interface YLYearMonthPicker : UIView

//@property (nonatomic, copy) YearMonthBlock YearMonthBlock;
@property (nonatomic, copy) CancelBlock cancelBlock;
@property (nonatomic, copy) SureBlock sureBlock;

@end

NS_ASSUME_NONNULL_END

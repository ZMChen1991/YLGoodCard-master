//
//  YLCityView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/27.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CancelBlock)(void);
typedef void(^SureBlock)(NSString *location);

@interface YLCityView : UIView


@property (nonatomic, copy) CancelBlock cancelBlock;
@property (nonatomic, copy) SureBlock sureBlock;


@end

NS_ASSUME_NONNULL_END

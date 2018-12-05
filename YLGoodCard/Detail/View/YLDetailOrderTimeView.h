//
//  YLDetailOrderTimeView.h
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CancelBlock)(void);
typedef void(^OrderTimeBlock)(NSString *orderTime);

@interface YLDetailOrderTimeView : UIView

@property (nonatomic, copy) CancelBlock cancelBlock;
@property (nonatomic, copy) OrderTimeBlock orderTimeBlock;

@end

NS_ASSUME_NONNULL_END

//
//  YLContactView.h
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ContactBlock)(void);
@interface YLContactView : UIView

@property (nonatomic, strong) NSString *message;
@property (nonatomic, copy) ContactBlock contactBlock;

@end

NS_ASSUME_NONNULL_END

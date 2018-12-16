//
//  YLCompleteView.h
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CompleteBlock)(void);
@interface YLCompleteView : UIView

@property (nonatomic, copy) CompleteBlock completeBlock;

@end

NS_ASSUME_NONNULL_END

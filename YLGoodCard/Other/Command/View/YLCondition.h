//
//  YLCondition.h
//  YLGoodCard
//
//  Created by lm on 2018/11/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YLConditionType) {
    YLConditionTypeBlue,        // 蓝底白字
    YLConditionTypeWhite,       // 白底蓝字
    YLConditionTypeGray,        // 灰底白字
};

@class YLCondition;
@protocol YLConditionDelegate <NSObject>
@optional
- (void)bargainPrice;
- (void)pushController:(UIButton *)sender;

@end

@interface YLCondition : UIButton

@property (nonatomic, assign) YLConditionType type;
@property (nonatomic, weak) id<YLConditionDelegate> delegate;

@end

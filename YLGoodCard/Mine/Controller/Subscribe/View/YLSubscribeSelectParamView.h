//
//  YLSubscribeSelectParamView.h
//  YLGoodCard
//
//  Created by lm on 2019/1/18.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^RestAllConditionBlock)(NSArray *multiSelectModels);
typedef void(^SureBlock)(NSArray *multiSelectModels);

@interface YLSubscribeSelectParamView : UIView

@property (nonatomic, copy) NSArray *multiSelectModels;
@property (nonatomic, copy) NSArray *headerTitles;

@property (nonatomic, copy) RestAllConditionBlock restAllConditionBlock;
@property (nonatomic, copy) SureBlock sureBlock;
@end

NS_ASSUME_NONNULL_END

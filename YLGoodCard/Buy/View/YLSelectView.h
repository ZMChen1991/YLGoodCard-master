//
//  YLSelectView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/10.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^RestAllConditionBlock)(NSArray *multiSelectModels);
typedef void(^SureBlock)(NSArray *multiSelectModels);

@interface YLSelectView : UIView

@property (nonatomic, copy) NSArray *multiSelectModels;
@property (nonatomic, copy) NSArray *headerTitles;

@property (nonatomic, copy) RestAllConditionBlock restAllConditionBlock;
@property (nonatomic, copy) SureBlock sureBlock;

@end

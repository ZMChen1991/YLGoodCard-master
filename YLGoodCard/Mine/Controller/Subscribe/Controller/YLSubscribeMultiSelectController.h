//
//  YLSubscribeMultiSelectController.h
//  YLGoodCard
//
//  Created by lm on 2019/1/18.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^RestAllConditionBlock)(NSArray *multiSelectModels);
typedef void(^SureBlock)(NSArray *multiSelectModels);

@interface YLSubscribeMultiSelectController : UIViewController

//@property (nonatomic, copy) NSArray *multiSelectModels;
//@property (nonatomic, copy) NSArray *headerTitles;

@property (nonatomic, copy) SureBlock sureBlock;
@property (nonatomic, copy) RestAllConditionBlock restAllConditionBlock;

@property (nonatomic, strong) NSMutableArray *selectParamModels;
@property (nonatomic, strong) NSArray *headerTitles;
@property (nonatomic, strong) NSString *lowPrice;
@property (nonatomic, strong) NSString *highPrice;

@end

NS_ASSUME_NONNULL_END

//
//  YLBuyCellFrame.h
//  YLGoodCard
//
//  Created by lm on 2018/11/23.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLBuyCellFrame : NSObject

@property (nonatomic, strong) YLTableViewModel *model;

@property (nonatomic, assign) CGRect iconF;
@property (nonatomic, assign) CGRect titleF;
@property (nonatomic, assign) CGRect courseF;
@property (nonatomic, assign) CGRect priceF;
@property (nonatomic, assign) CGRect originalPriceF;
@property (nonatomic, assign) CGRect downIconF;
@property (nonatomic, assign) CGRect downTitleF;
@property (nonatomic, assign) CGRect bargainF;
@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END

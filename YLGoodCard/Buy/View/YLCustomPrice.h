//
//  YLCustomPrice.h
//  YLGoodCard
//
//  Created by lm on 2018/11/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBuyConditionModel.h"


typedef void(^CustomPriceBlock)(NSArray *priceModels);
typedef void(^SurePriceBlock)(NSString *lowPrice, NSString *highPrice);
//@class YLCustomPrice;
//@protocol YLCustomPriceDelegate <NSObject>
//@optional
//- (void)pushLowPrice:(NSString *)lowPrice highPrice:(NSString *)highPrice;
//@end


@interface YLCustomPrice : UIView

@property (nonatomic, copy) CustomPriceBlock customPriceBlock;
@property (nonatomic, copy) SurePriceBlock surePriceBlock;
//@property (nonatomic, weak) id<YLCustomPriceDelegate> delegate;

@property (nonatomic, copy) NSArray *models;
//@property (nonatomic, strong) YLBuyConditionModel *lowModel;
//@property (nonatomic, strong) YLBuyConditionModel *highModel;


@end

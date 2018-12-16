//
//  YLBargainPriceView.h
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBargainDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BargainPriceBlock)(NSString *bargainPrice);
typedef void(^BargainPriceCancelBlock)(void);

@interface YLBargainPriceView : UIView

@property (nonatomic, strong) YLBargainDetailModel *model;
@property (nonatomic, strong) NSString *buyerPrice;
@property (nonatomic, strong) NSString *sellerPrice;
@property (nonatomic, strong) NSString *buyer;
@property (nonatomic, strong) NSString *seller;
@property (nonatomic, assign) BOOL isBuyer;

@property (nonatomic, copy) BargainPriceBlock bargainPriceBlock;
@property (nonatomic, copy) BargainPriceCancelBlock bargainPriceCancelBlock;

@end

NS_ASSUME_NONNULL_END

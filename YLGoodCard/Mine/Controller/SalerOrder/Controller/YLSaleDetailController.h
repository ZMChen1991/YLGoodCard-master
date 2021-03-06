//
//  YLSaleDetailController.h
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSaleOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SaleDetailBlock)(void);

@interface YLSaleDetailController : UIViewController

@property (nonatomic, strong) YLSaleOrderModel *model;

@property (nonatomic, copy) SaleDetailBlock saleDetailBlock;

@end

NS_ASSUME_NONNULL_END

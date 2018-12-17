//
//  YLCommandView.h
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSaleOrderModel.h"
#import "YLTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SaleOrderCommandBlock)(YLTableViewModel *model);
@interface YLCommandView : UIView

@property (nonatomic, strong) YLSaleOrderModel *model;
@property (nonatomic, copy) SaleOrderCommandBlock saleOrderCommandBlock;

@end

NS_ASSUME_NONNULL_END

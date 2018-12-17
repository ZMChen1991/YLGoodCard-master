//
//  YLBuyOrderCommand.h
//  YLGoodCard
//
//  Created by lm on 2018/12/10.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBuyOrderModel.h"
#import "YLTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BuyOrderCommandBlock)(YLTableViewModel *model);

@interface YLBuyOrderCommand : UIView

@property (nonatomic, strong) YLBuyOrderModel *model;
@property (nonatomic, copy) BuyOrderCommandBlock buyOrderCommandBlock;

@end

NS_ASSUME_NONNULL_END

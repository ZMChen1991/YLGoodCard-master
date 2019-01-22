//
//  YLSubscribeSeriesController.h
//  YLGoodCard
//
//  Created by lm on 2019/1/18.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBrandModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^BuySeriesBlock)(NSString *series);

@interface YLSubscribeSeriesController : UITableViewController

@property (nonatomic, strong) YLBrandModel *model;
@property (nonatomic, copy) BuySeriesBlock buySeriesBlock;

@end

NS_ASSUME_NONNULL_END

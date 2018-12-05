//
//  YLSaleOrderModel.h
//  YLGoodCard
//
//  Created by lm on 2018/12/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLSaleOrderDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLSaleOrderModel : NSObject

@property (nonatomic, strong) YLSaleOrderDetailModel *detail;

@end

NS_ASSUME_NONNULL_END

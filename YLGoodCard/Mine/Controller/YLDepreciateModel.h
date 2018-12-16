//
//  YLDepreciateModel.h
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLDepreciateDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLDepreciateModel : NSObject

@property (nonatomic, strong) YLDepreciateDetailModel *detail;
@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *prePrice;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *priceSpread;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, strong) NSString *updateAt;

@end

NS_ASSUME_NONNULL_END

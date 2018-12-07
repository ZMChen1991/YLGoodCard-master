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
//@property (nonatomic, strong) NSString *carID;
@property (nonatomic, strong) NSString *remarks;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *book;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, strong) NSString *updateAt;
@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *centerId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *examineTime;



@end

NS_ASSUME_NONNULL_END

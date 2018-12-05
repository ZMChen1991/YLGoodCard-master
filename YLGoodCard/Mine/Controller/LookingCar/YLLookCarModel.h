//
//  YLLookCarModel.h
//  YLGoodCard
//
//  Created by lm on 2018/11/29.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLLookCarDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLLookCarModel : NSObject

@property (nonatomic, strong) NSString *appointTime;
@property (nonatomic, strong) YLLookCarDetailModel *detail;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, strong) NSString *updateAt;
@property (nonatomic, strong) NSString *finalPrice;
@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *centerId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *remarks;

@end

NS_ASSUME_NONNULL_END

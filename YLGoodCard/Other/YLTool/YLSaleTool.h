//
//  YLSaleTool.h
//  YLGoodCard
//
//  Created by lm on 2018/11/22.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBaseTool.h"
#import "YLDetectCenterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLSaleTool : YLBaseTool


/**
客户预约卖车
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)saleWithParam:(id)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError * _Nonnull))failure;

/**
根据检测中心ID获取检测中心的详情
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)detectDetailWithParam:(id)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError * _Nonnull))failure;

/**
根据城市获取该城市的检测中心
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)cityDetectWithParam:(id)param success:(void (^)(NSArray<YLDetectCenterModel *> *result))success failure:(void (^)(NSError * _Nonnull))failure;

@end

NS_ASSUME_NONNULL_END

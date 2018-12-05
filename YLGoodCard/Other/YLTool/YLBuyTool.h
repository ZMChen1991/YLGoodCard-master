//
//  YLBuyTool.h
//  YLGoodCard
//
//  Created by lm on 2018/11/22.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//
// 品牌、车系
// 根据搜索条件获取的车辆列表


#import "YLBaseTool.h"
#import "YLTableViewModel.h"
#import "YLBrandModel.h"
#import "YLSeriesModel.h"
#import "YLCarTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLBuyTool : YLBaseTool

/**
 根据搜索获取购车列表数据
 
 @param param 请求参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)buyWithParam:(id)param success:(void(^)(NSArray<YLTableViewModel *> *result))success failure:(void (^)(NSError *error))failure;


/**
 获取车辆品牌数据
 
 @param param 参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)brandWithParam:(id)param success:(void (^)(NSArray<YLBrandModel *> *result))success failure:(void (^)(NSError * error))failure;

/**
 获取车辆车系数据
 
 @param param 参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)seriesWithParam:(id)param success:(void (^)(NSArray<YLSeriesModel *> *result))success failure:(void (^)(NSError * error))failure;

/**
 获取车辆车型数据
 
 @param param 参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)carTypeWithParam:(id)param success:(void (^)(NSArray<YLCarTypeModel *> *result))success failure:(void (^)(NSError * error))failure;

@end

NS_ASSUME_NONNULL_END

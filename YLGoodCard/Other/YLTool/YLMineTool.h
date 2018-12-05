//
//  YLMineTool.h
//  YLGoodCard
//
//  Created by lm on 2018/11/22.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

// 即将看车、卖车订单、买车订单、砍价记录（买家/卖家砍价和砍价详情）

#import "YLBaseTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLMineTool : YLBaseTool

/**
即将看车列表
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)lookforWithParam:(id)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError * error))failure;

/**
我的收藏、即将看车、砍价条数
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)favoriteWithParam:(id)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError * error))failure;

/**
 我的收藏
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)collectWithParam:(id)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError * error))failure;

/**
卖车订单列表
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)saleOrderWithParam:(id)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError * error))failure;

/**
买车订单列表
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)buyOrderWithParam:(id)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError * error))failure;

/**
 买家的砍价列表
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)buyBargainWithParam:(id)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError * error))failure;

/**
 买家的砍价详情
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)buyBargainDetailWithParam:(id)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError * error))failure;


/**
 卖家的砍价列表
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)saleBargainWithParam:(id)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError * error))failure;

/**
 卖家的砍价详情
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)saleBargainDetailWithParam:(id)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError * error))failure;


@end

NS_ASSUME_NONNULL_END

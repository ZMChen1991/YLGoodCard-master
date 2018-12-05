//
//  YLDetailTool.h
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

// 收藏、详情、砍价、预约看车、更多配置

#import "YLBaseTool.h"
#import "YLDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLDetailTool : YLBaseTool


/**
 获取车辆详情
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)detailWithParam:(id)param success:(void (^)(YLDetailModel *result))success failure:(void (^)(NSError * _Nonnull))failure;

/**
 车辆收藏或取消
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)favoriteWithParam:(id)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError * _Nonnull))failure;

/**
预约看车
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)lookCarWithParam:(id)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError * _Nonnull))failure;

/**
车辆砍价
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)bargainWithParam:(id)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError * _Nonnull))failure;

/**
车辆更多配置
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)configWithParam:(id)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError * _Nonnull))failure;

@end

NS_ASSUME_NONNULL_END

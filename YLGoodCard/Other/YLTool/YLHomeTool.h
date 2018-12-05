//
//  YLHomeTool.h
//  YLGoodCard
//
//  Created by lm on 2018/11/22.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

// s轮播图、成交记录、推荐列表

#import "YLBaseTool.h"
#import "YLBannerModel.h"
#import "YLNotableModel.h"
#import "YLTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLHomeTool : YLBaseTool

/**
 加载轮转图信息
 
 @param param 请求参数
 @param success 请求成功后的回调（应该回调模型，而不是类，这里需要修改）
 @param failure 请求失败后的回调
 */
+ (void)bannerWithParam:(id)param success:(void(^)(NSArray<YLBannerModel *> *result))success failure:(void (^)(NSError *error))failure;

/**
 加载走马灯广告信息（用户成交信息）
 
 @param param 请求参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)notableWithParam:(id)param success:(void(^)(NSArray<YLNotableModel *> *result))success failure:(void (^)(NSError *error))failure;


/**
 推荐列表数据
 
 @param param 请求参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)recommendWithParam:(id)param success:(void(^)(NSArray<YLTableViewModel *> *result))success failure:(void (^)(NSError *error))failure;

/**
 推荐热门汽车品牌
 
 @param param 请求参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)hotBrandWithParam:(id)param success:(void(^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END

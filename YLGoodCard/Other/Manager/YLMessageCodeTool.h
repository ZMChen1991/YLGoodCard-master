//
//  YLMessageCodeTool.h
//  YLGoodCard
//
//  Created by lm on 2018/11/21.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBaseTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLMessageCodeTool : NSObject

/**
短信验证码
 
 @param param 请求参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)messageCodeWithParam:(id)param success:(void(^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;


+ (void)loginWithParam:(id)param success:(void(^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END

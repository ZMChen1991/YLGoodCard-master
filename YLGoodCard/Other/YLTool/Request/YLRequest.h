//
//  YLRequest.h
//  YLGoodCard
//
//  Created by lm on 2018/11/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DMNetWorkStatus) {
    
    // 未知网络
    DMNetWorkStatusUnknow,
    // 无网络
    DMNetWorkStatusNotReachable,
    // 手机网络
    DMNetWorkStatusReachableViaWWAN,
    // WIFI
    DMNetWorkStatusReachableViaWIFI
};

typedef NS_ENUM(NSUInteger, DMResponseSerializerType) {
    
    // 响应数据为JSON格式
    DMResponseSerializerJSON,
    // 响应数据为二进制格式
    DMResponseSerializerHTTP
};

typedef NS_ENUM(NSUInteger, DMResquestSerializerTYpe) {
    
    // 响应数据为JSON格式
    DMResquestSerializerJSON,
    // 响应数据为二进制格式
    DMResquestSerializerHTTP
};

// 缓存的block
typedef void(^DMHTTPRequestCache)(id responseCache);
// 请求成功的block
typedef void(^DMHTTPRequestSuccess)(id responseObject);
// 请求失败的block
typedef void(^DMHTTPRequestFailed)(NSError *error);
// 请求进度的block
typedef void(^DMHTTPRequestProgress)(NSProgress *progress);
// 网络状态的block
typedef void(^DMNetworkStatus)(DMNetWorkStatus status);

@interface YLRequest : NSObject

YLSingletonH

// 网络检测
+ (void)reachabilityStatus;

/**
 GET请求
 
 @param URL 请求地址
 @param parameters 请求参数
 @param requestCache 缓存数据的回调
 @param success 请求成功的回调
 @param failed 请求失败的回调
 */
+ (void)GET:(NSString *)URL parameters:(id)parameters responseCache:(DMHTTPRequestCache)requestCache success:(DMHTTPRequestSuccess)success failed:(DMHTTPRequestFailed)failed;


/**
 GET请求
 
 @param URL 请求地址
 @param parameters 请求参数
 @param success 请求成功的回调
 @param failed 请求失败的回调
 */
+ (void)GET:(NSString *)URL parameters:(id)parameters success:(DMHTTPRequestSuccess)success failed:(DMHTTPRequestFailed)failed;

/**
 POST请求
 
 @param URL 请求地址
 @param parameters 请求参数
 @param requestCache 缓存数据的回调
 @param success 请求成功的回调
 @param failed 请求失败的回调
 */
+ (void)POST:(NSString *)URL parameters:(id)parameters responseCache:(DMHTTPRequestCache)requestCache success:(DMHTTPRequestSuccess)success failed:(DMHTTPRequestFailed)failed;

/**
 GET请求
 
 @param URL 请求地址
 @param parameters 请求参数
 @param requestCache 缓存数据的回调
 @param success 请求成功的回调
 @param failed 请求失败的回调
 */
- (void)GET:(NSString *)URL parameters:(id)parameters responseCache:(DMHTTPRequestCache)requestCache success:(DMHTTPRequestSuccess)success failed:(DMHTTPRequestFailed)failed;

/**
 POST请求
 
 @param URL 请求地址
 @param parameters 请求参数
 @param requestCache 缓存数据的回调
 @param success 请求成功的回调
 @param failed 请求失败的回调
 */
- (void)POST:(NSString *)URL parameters:(id)parameters responseCache:(DMHTTPRequestCache)requestCache success:(DMHTTPRequestSuccess)success failed:(DMHTTPRequestFailed)failed;


@end

NS_ASSUME_NONNULL_END

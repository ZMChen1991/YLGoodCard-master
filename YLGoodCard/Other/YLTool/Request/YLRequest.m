//
//  YLRequest.m
//  YLGoodCard
//
//  Created by lm on 2018/11/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLRequest.h"

@implementation YLRequest
YLSingletonM

+ (void)reachabilityStatus {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager manager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"自带网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            default:
                break;
        }
    }];
    // 开始监控
    [manager startMonitoring];
}


+ (void)GET:(NSString *)URL parameters:(id)parameters success:(DMHTTPRequestSuccess)success failed:(DMHTTPRequestFailed)failed {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (success) {
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
}

+ (void)GET:(NSString *)URL parameters:(id)parameters responseCache:(DMHTTPRequestCache)requestCache success:(DMHTTPRequestSuccess)success failed:(DMHTTPRequestFailed)failed {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSData *date = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"YLRequest:%@",dict);
        if (success) {
            success(dict);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
}

+ (void)POST:(NSString *)URL parameters:(id)parameters responseCache:(DMHTTPRequestCache)requestCache success:(DMHTTPRequestSuccess)success failed:(DMHTTPRequestFailed)failed {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (success) {
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
}

- (void)GET:(NSString *)URL parameters:(id)parameters responseCache:(DMHTTPRequestCache)requestCache success:(DMHTTPRequestSuccess)success failed:(DMHTTPRequestFailed)failed {
    
    [YLRequest GET:URL parameters:parameters responseCache:requestCache success:success failed:failed];
}

- (void)POST:(NSString *)URL parameters:(id)parameters responseCache:(DMHTTPRequestCache)requestCache success:(DMHTTPRequestSuccess)success failed:(DMHTTPRequestFailed)failed {
    
    [YLRequest POST:URL parameters:parameters responseCache:requestCache success:success failed:failed];
}

@end

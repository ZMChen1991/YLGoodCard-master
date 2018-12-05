//
//  YLMessageCodeTool.m
//  YLGoodCard
//
//  Created by lm on 2018/11/21.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLMessageCodeTool.h"
#import "YLRequest.h"

@implementation YLMessageCodeTool

+ (void)messageCodeWithParam:(id)param success:(void (^)(NSDictionary * result))success failure:(void (^)(NSError *error))failure {
    NSString *urlString = @"http://ucarjava.bceapp.com/sms?method=sendSms";
    [YLRequest GET:urlString parameters:param responseCache:nil success:success failed:failure];
}

+ (void)loginWithParam:(id)param success:(void (^)(NSDictionary * result))success failure:(void (^)(NSError *error))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/sms?method=checkCode";
    [YLRequest GET:urlString parameters:param responseCache:nil success:^(id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failed:^(NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
}

//+ (void)GET:(NSString *)URL parameters:(id)parameters responseCache:(DMHTTPRequestCache)requestCache success:(DMHTTPRequestSuccess)success failed:(DMHTTPRequestFailed)failed {
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"YLRequest:%@",dict);
//        if (success) {
//            success(dict);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failed) {
//            failed(error);
//        }
//    }];
//}

@end

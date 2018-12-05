//
//  YLDetailTool.m
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailTool.h"
#import "YLRequest.h"

@implementation YLDetailTool

+ (void)detailWithParam:(id)param success:(void (^)(YLDetailModel *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/detail?method=id";
    [YLRequest GET:urlString parameters:param responseCache:nil success:^(id  _Nonnull responseObject) {
        if (success) {
            id result = [[YLDetailModel class] mj_objectWithKeyValues:responseObject[@"data"][@"detail"]];
            success(result);// 返回的是存放模型类的数组
        }
    } failed:nil];
}

+ (void)favoriteWithParam:(id)param success:(void (^)(NSDictionary * result))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/collection?method=upd";
    [self getWithUrl:urlString param:param dictForResultClass:[NSDictionary class] success:success failure:failure];
}

+ (void)lookCarWithParam:(id)param success:(void (^)(NSDictionary * result))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/buy?method=order";
    [YLRequest GET:urlString parameters:param responseCache:nil success:^(id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);// 返回的是存放模型类的数组
        }
    } failed:nil];
}

+ (void)bargainWithParam:(id)param success:(void (^)(NSDictionary * result))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/bargain?method=dicker";
//    [self getWithUrl:urlString param:param dictForResultClass:[NSDictionary class] success:success failure:failure];
    [YLRequest GET:urlString parameters:param responseCache:nil success:^(id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failed:nil];
}

+ (void)configWithParam:(id)param success:(void (^)(NSDictionary * result))success failure:(void (^)(NSError * _Nonnull))failure {
    NSString *urlString = @"http://ucarjava.bceapp.com/detail?method=config";
    [self getWithUrl:urlString param:param dictForResultClass:[NSDictionary class] success:success failure:failure];
}

@end

//
//  YLMineTool.m
//  YLGoodCard
//
//  Created by lm on 2018/11/22.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLMineTool.h"
#import "YLRequest.h"
#import "YLLookCarModel.h"
#import "YLCollectionModel.h"

@implementation YLMineTool

+ (void)lookforWithParam:(id)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/buy?method=my";
    [YLRequest GET:urlString parameters:param responseCache:nil success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            return ;
        } else {
//            NSDictionary *dict = responseObject[@"data"];
            if (success) {
                id result = [[YLLookCarModel class] mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                success(result);
            }
        }
    } failed:nil];
}

+ (void)favoriteWithParam:(id)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError * error))failure {
    NSString *urlString = @"http://ucarjava.bceapp.com/home?method=num";
    [YLRequest GET:urlString parameters:param responseCache:nil success:^(id  _Nonnull responseObject) {
//        NSLog(@"%@", responseObject[@"data"]);
        NSDictionary *dict = responseObject[@"data"];
        if (success) {
            success(dict);
        }
    } failed:nil];
}

+ (void)collectWithParam:(id)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError * error))failure {
    NSString *urlString = @"http://ucarjava.bceapp.com/collection?method=my";
    [YLRequest GET:urlString parameters:param responseCache:nil success:^(id  _Nonnull responseObject) {

        id result = [YLCollectionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (success) {
            success(result);
        }
    } failed:nil];
}

+ (void)saleOrderWithParam:(id)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/sell?method=my";
    [self getWithUrl:urlString param:param arrayForResultClass:[NSArray class] success:success failure:failure];
}

+ (void)buyOrderWithParam:(id)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/buy?method=my";
    [self getWithUrl:urlString param:param arrayForResultClass:[NSArray class] success:success failure:failure];
}

+ (void)buyBargainWithParam:(id)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/bargain?method=buyer";
    [self getWithUrl:urlString param:param arrayForResultClass:[NSArray class] success:success failure:failure];
}

+ (void)buyBargainDetailWithParam:(id)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/bargain?method=binfo";
    [self getWithUrl:urlString param:param arrayForResultClass:[NSArray class] success:success failure:failure];
}

+ (void)saleBargainDetailWithParam:(id)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/bargain?method=seller";
    [self getWithUrl:urlString param:param arrayForResultClass:[NSArray class] success:success failure:failure];
}

+ (void)saleBargainWithParam:(id)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/bargain?method=sinfo";
    [self getWithUrl:urlString param:param arrayForResultClass:[NSArray class] success:success failure:failure];
}


@end

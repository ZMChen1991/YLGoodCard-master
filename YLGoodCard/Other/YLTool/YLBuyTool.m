//
//  YLBuyTool.m
//  YLGoodCard
//
//  Created by lm on 2018/11/22.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBuyTool.h"

@implementation YLBuyTool

+ (void)buyWithParam:(id)param success:(void (^)(NSArray<YLTableViewModel *> * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/detail?method=search";
    [self getWithUrl:urlString param:param arrayForResultClass:[YLTableViewModel class] success:success failure:failure];
}

+ (void)brandWithParam:(id)param success:(void (^)(NSArray<YLBrandModel *> * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/vehicle?method=brand";
     [self getWithUrl:urlString param:param arrayForResultClass:[YLBrandModel class] success:success failure:failure];
}

+ (void)seriesWithParam:(id)param success:(void (^)(NSArray<YLSeriesModel *> * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    NSString *urlString = @"http://ucarjava.bceapp.com/vehicle?method=series";
     [self getWithUrl:urlString param:param arrayForResultClass:[YLSeriesModel class] success:success failure:failure];
    
}

+ (void)carTypeWithParam:(id)param success:(void (^)(NSArray<YLCarTypeModel *> * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/vehicle?method=config";
    [self getWithUrl:urlString param:param arrayForResultClass:[YLCarTypeModel class] success:success failure:failure];
}

@end

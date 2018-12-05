//
//  YLHomeTool.m
//  YLGoodCard
//
//  Created by lm on 2018/11/22.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLHomeTool.h"

@implementation YLHomeTool

+ (void)bannerWithParam:(id)param success:(void (^)(NSArray<YLBannerModel *> *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/home?method=play";
    [self getWithUrl:urlString param:param arrayForResultClass:[YLBannerModel class] success:success failure:failure];
}

+ (void)notableWithParam:(id)param success:(void (^)(NSArray<YLNotableModel *> *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/trade?method=random";
    [self getWithUrl:urlString param:param arrayForResultClass:[YLNotableModel class] success:success failure:failure];
    //    NSLog(@"%@",success);
}

+ (void)recommendWithParam:(id)param success:(void (^)(NSArray<YLTableViewModel *> *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/detail?method=recommend";
    [self getWithUrl:urlString param:param arrayForResultClass:[YLTableViewModel class] success:success failure:failure];
}

+ (void)hotBrandWithParam:(id)param success:(void (^)(NSDictionary * result))success failure:(void (^)(NSError * error))failure {

    NSString *urlString = @"http://ucarjava.bceapp.com/home?method=brand";
    [self getWithUrl:urlString param:param success:success failure:failure];
}

@end

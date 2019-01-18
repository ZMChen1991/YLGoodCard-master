//
//  YLSubscribeModel.m
//  YLGoodCard
//
//  Created by lm on 2019/1/16.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLSubscribeModel.h"
#import "YLSubscribeDetailModel.h"

@implementation YLSubscribeModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"subscribeId":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"result":[YLSubscribeDetailModel class]};
}

@end

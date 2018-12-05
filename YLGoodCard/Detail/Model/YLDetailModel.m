//
//  YLDetailModel.m
//  YLGoodCard
//
//  Created by lm on 2018/11/14.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailModel.h"

@implementation YLDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"carID":@"id"};
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)initWithDict:(NSDictionary *)dict {
    return [[YLDetailModel alloc] initWithDict:dict];
}



@end

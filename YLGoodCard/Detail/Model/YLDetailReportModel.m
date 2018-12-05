//
//  YLDetailReportModel.m
//  YLGoodCard
//
//  Created by lm on 2018/11/20.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailReportModel.h"

@implementation YLDetailReportModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)initWithDict:(NSDictionary *)dict {
    return [[YLDetailReportModel alloc] initWithDict:dict];
}

@end

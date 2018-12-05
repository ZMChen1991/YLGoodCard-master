//
//  YLBrandModel.m
//  YLGoodCard
//
//  Created by lm on 2018/11/16.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBrandModel.h"

@implementation YLBrandModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.brand forKey:@"brand"];
    [aCoder encodeObject:self.brandId forKey:@"brandId"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.initialLetter forKey:@"initialLetter"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.thumb forKey:@"thumb"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.brand = [aDecoder decodeObjectForKey:@"brand"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.brandId = [aDecoder decodeObjectForKey:@"brandId"];
        self.initialLetter = [aDecoder decodeObjectForKey:@"initialLetter"];
        self.thumb = [aDecoder decodeObjectForKey:@"thumb"];
        self.country = [aDecoder decodeObjectForKey:@"country"];
    }
    return self;
}
@end

//
//  YLTableViewModel.m
//  YLYouka
//
//  Created by lm on 2018/11/14.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLTableViewModel.h"

@implementation YLTableViewModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"carID":@"id"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.carID forKey:@"carID"];
    [aCoder encodeObject:self.displayImg forKey:@"displayImg"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.course forKey:@"course"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.originalPrice forKey:@"originalPrice"];
    [aCoder encodeObject:self.downPrice forKey:@"downPrice"];
    [aCoder encodeObject:self.bargain forKey:@"bargain"];
    [aCoder encodeObject:self.status forKey:@"status"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.carID = [aDecoder decodeObjectForKey:@"carID"];
        self.displayImg = [aDecoder decodeObjectForKey:@"displayImg"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.course = [aDecoder decodeObjectForKey:@"course"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.originalPrice = [aDecoder decodeObjectForKey:@"originalPrice"];
        self.bargain = [aDecoder decodeObjectForKey:@"bargain"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.downPrice = [aDecoder decodeObjectForKey:@"downPrice"];
    }
    return self;
}
@end

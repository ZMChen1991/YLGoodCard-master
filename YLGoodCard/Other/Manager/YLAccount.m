//
//  YLAccount.m
//  YLGoodCard
//
//  Created by lm on 2018/11/21.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLAccount.h"
#import "YLAccountTool.h"

@implementation YLAccount

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    
    YLAccount *account = [YLAccountTool account];
    if (!account) {
        account = [[self alloc] init];
    }
//    YLAccount *account = [[self alloc] init];
    account.telephone = dict[@"telephone"];
    account.status = dict[@"status"];
    account.ID = dict[@"ID"];
    account.token = dict[@"token"];
    account.lastTime = account.updateAt;
    account.updateAt = dict[@"updateAt"];
    return account;
}

//- (NSString *)stringWithDate:(NSDate *)date {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
//    return [formatter stringFromDate:date];
//}

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.telephone forKey:@"telephone"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.updateAt forKey:@"updateAt"];
    [aCoder encodeObject:self.lastTime forKey:@"lastTime"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.telephone = [aDecoder decodeObjectForKey:@"telephone"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.updateAt = [aDecoder decodeObjectForKey:@"updateAt"];
        self.lastTime = [aDecoder decodeObjectForKey:@"lastTime"];
    }
    return self;
}


@end

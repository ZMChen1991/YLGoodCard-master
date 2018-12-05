//
//  YLAccountTool.m
//  YLGoodCard
//
//  Created by lm on 2018/11/21.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

// 账号存储路径
#define YLAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.plist"]

#import "YLAccountTool.h"

@implementation YLAccountTool

+ (void)saveAccount:(YLAccount *)account {
    NSLog(@"%@", YLAccountPath);
    [NSKeyedArchiver archiveRootObject:account toFile:YLAccountPath];
}

+ (YLAccount *)account {
    
    YLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:YLAccountPath];
    // 此处没有想好，以后再修改
    // 如果登录时间超过1小时，
//    long long time = 3600;
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
//    NSString *string = [NSString stringWithFormat:@"%@", account.updateAt];
//    NSDate *date = [formatter dateFromString:string];
//    NSDate *expirseTime = [account.lastTime dateByAddingTimeInterval:time];
//    NSDate *now = [NSDate date];
//    NSLog(@"%@----%@", expirseTime, now);
//    NSComparisonResult result = [expirseTime compare:now];
//    if (result != NSOrderedDescending) {
//        return nil;
//    }
    return account;
}

+ (void)loginOut {
    YLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:YLAccountPath];
    account = nil;
    [self saveAccount:account];
}

@end

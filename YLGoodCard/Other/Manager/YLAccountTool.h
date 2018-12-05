//
//  YLAccountTool.h
//  YLGoodCard
//
//  Created by lm on 2018/11/21.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLAccount.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLAccountTool : NSObject


/**
 存储账号信息

 @param account 账号模型
 */
+ (void)saveAccount:(YLAccount *)account;


/**
 返回账号信息

 @return 账号模型
 */
+ (YLAccount *)account;

+ (void)loginOut;

@end

NS_ASSUME_NONNULL_END

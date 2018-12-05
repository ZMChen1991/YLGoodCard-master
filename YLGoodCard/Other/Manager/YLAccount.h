//
//  YLAccount.h
//  YLGoodCard
//
//  Created by lm on 2018/11/21.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLAccount : NSObject <NSCoding>

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *token;
//@property (nonatomic, strong) NSDate *loginTime;// 登录时间
@property (nonatomic, strong) NSDate *lastTime;// 上次登录时间
@property (nonatomic, strong) NSDate *updateAt;// 登录时间

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

//
//  YLBaseTool.h
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLBaseTool : NSObject

+ (void)getWithUrl:(NSString *)url param:(id)param arrayForResultClass:(Class)resultClass success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

+ (void)getWithUrl:(NSString *)url param:(id)param dictForResultClass:(Class)resultClass success:(void (^)(id result))success failure:(void (^)(NSError * error))failure;

+ (void)getWithUrl:(NSString *)url param:(id)param success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

+ (void)getWithUrl:(NSString *)url param:(id)param dataForResultClass:(Class)resultClass success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END

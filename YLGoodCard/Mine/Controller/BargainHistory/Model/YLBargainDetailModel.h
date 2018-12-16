//
//  YLBargainDetailModel.h
//  YLGoodCard
//
//  Created by lm on 2018/12/11.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLBargainDetailModel : NSObject

@property (nonatomic, assign) BOOL isBuyer;

@property (nonatomic, strong) NSString *bargainId;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *buyer;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *updateAt;
@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) NSString *mark; // 1：砍价 2、还价
@property (nonatomic, strong) NSString *relatedId;
@property (nonatomic, strong) NSString *seller;
@property (nonatomic, strong) NSString *status; // 1：生效、0:失效、2:接受

@end

NS_ASSUME_NONNULL_END

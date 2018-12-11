//
//  YLBargainHistoryModel.h
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLBargainHistoryDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLBargainHistoryModel : NSObject

@property (nonatomic, strong) YLBargainHistoryDetailModel *detail;
@property (nonatomic, strong) NSString *buyer;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *updateAt;
@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) NSString *mark;
@property (nonatomic, strong) NSString *relatedId;
@property (nonatomic, strong) NSString *seller;
@property (nonatomic, strong) NSString *status;

@end

NS_ASSUME_NONNULL_END

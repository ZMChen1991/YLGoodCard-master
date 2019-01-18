//
//  YLSubscribeCellFrame.h
//  YLGoodCard
//
//  Created by lm on 2019/1/16.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLSubscribeDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLSubscribeCellFrame : NSObject

@property (nonatomic, strong) YLSubscribeDetailModel *model;

@property (nonatomic, assign) CGRect iconF;
@property (nonatomic, assign) CGRect titleF;
@property (nonatomic, assign) CGRect courseF;
@property (nonatomic, assign) CGRect priceF;
@property (nonatomic, assign) CGRect originalPriceF;
@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END

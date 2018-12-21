//
//  YLTableViewCellFrame.h
//  YLGoodCard
//
//  Created by lm on 2018/12/20.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLTableViewCellFrame : NSObject

@property (nonatomic, strong) YLTableViewModel *model;

@property (nonatomic, assign) CGRect displayImgF;
@property (nonatomic, assign) CGRect titleF;
@property (nonatomic, assign) CGRect courseF;
@property (nonatomic, assign) CGRect priceF;
@property (nonatomic, assign) CGRect originalPriceF;
//@property (nonatomic, assign) CGRect iconF;

@end

NS_ASSUME_NONNULL_END

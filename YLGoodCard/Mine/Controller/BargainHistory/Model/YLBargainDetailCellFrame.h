//
//  YLBargainDetailCellFrame.h
//  YLGoodCard
//
//  Created by lm on 2018/12/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLBargainDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLBargainDetailCellFrame : NSObject

@property (nonatomic, strong) YLBargainDetailModel *model;

@property (nonatomic, assign) CGRect titleF;
@property (nonatomic, assign) CGRect dickerF;
@property (nonatomic, assign) CGRect acceptF;
@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END

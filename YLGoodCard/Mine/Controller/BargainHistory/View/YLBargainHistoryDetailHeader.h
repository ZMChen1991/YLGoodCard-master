//
//  YLBargainHistoryDetailHeader.h
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBargainHistoryModel.h"
#import "YLTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BargainHistoryBlock)(YLTableViewModel *model);
@interface YLBargainHistoryDetailHeader : UIView

@property (nonatomic, strong) YLBargainHistoryModel *model;
@property (nonatomic, copy) BargainHistoryBlock bargainHistoryBlock;

@end

NS_ASSUME_NONNULL_END

//
//  YLBargainHistoryDetailController.h
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBargainHistoryModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BargainDetailBlock)(void);

@interface YLBargainHistoryDetailController : UIViewController

@property (nonatomic, strong) YLBargainHistoryModel *model;
@property (nonatomic, copy) BargainDetailBlock bargainDetailBlock;

@property (nonatomic, assign) BOOL isBuyer;

@end

NS_ASSUME_NONNULL_END

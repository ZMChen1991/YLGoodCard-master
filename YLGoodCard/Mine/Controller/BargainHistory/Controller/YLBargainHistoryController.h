//
//  YLBargainHistoryController.h
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSkipView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLBargainHistoryController : UIViewController

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) YLSkipView *skip;
@end

NS_ASSUME_NONNULL_END

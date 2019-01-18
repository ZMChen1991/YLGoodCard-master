//
//  YLSubscribeDetailController.h
//  YLGoodCard
//
//  Created by lm on 2019/1/17.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSubscribeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLSubscribeDetailController : UITableViewController

@property (nonatomic, strong) NSArray *params;
@property (nonatomic, strong) YLSubscribeModel *model;

@end

NS_ASSUME_NONNULL_END

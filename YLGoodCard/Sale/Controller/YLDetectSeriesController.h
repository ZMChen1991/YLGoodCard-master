//
//  YLDetectSeriesController.h
//  YLGoodCard
//
//  Created by lm on 2018/12/4.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBrandModel.h"
#import "YLCarTypeController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SeriesBlock)(NSString *series, NSString *carType, NSString *typeId);

@interface YLDetectSeriesController : UITableViewController

@property (nonatomic, strong) YLBrandModel *model;
@property (nonatomic, strong) YLCarTypeController *cartype;

@property (nonatomic, copy) SeriesBlock seriesBlock;

@end

NS_ASSUME_NONNULL_END

//
//  YLSeriesView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/26.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSeriesModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SeriesBlock)(YLSeriesModel *seriesModel);

@interface YLSeriesView : UIView

@property (nonatomic, strong) NSArray *series;

@property (nonatomic, copy) SeriesBlock seriesBlock;

@end

NS_ASSUME_NONNULL_END

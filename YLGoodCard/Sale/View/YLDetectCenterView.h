//
//  YLDetectCenterView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLDetectCenterModel.h"

NS_ASSUME_NONNULL_BEGIN

@class YLDetectCenterView;
@protocol YLDetectCenterViewDelegate <NSObject>
@optional
- (void)detectCenterClick:(YLDetectCenterModel *)model;
@end

@interface YLDetectCenterView : UIView

@property (nonatomic, weak) id<YLDetectCenterViewDelegate> delegate;
@property (nonatomic, strong) NSArray *detectCenters;


@end

NS_ASSUME_NONNULL_END

//
//  YLSubcribeViewCell.h
//  YLGoodCard
//
//  Created by lm on 2019/1/16.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSubscribeDetailModel.h"
#import "YLSubscribeCellFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLSubcribeViewCell : UICollectionViewCell

@property (nonatomic, strong) YLSubscribeDetailModel *model;
@property (nonatomic, strong) YLSubscribeCellFrame *cellFrame;

@end

NS_ASSUME_NONNULL_END

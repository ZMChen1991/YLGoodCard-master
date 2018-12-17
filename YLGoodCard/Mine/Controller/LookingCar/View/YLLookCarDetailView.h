//
//  YLLookCarDetailView.h
//  YLGoodCard
//
//  Created by lm on 2018/12/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLLookCarModel.h"
#import "YLTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LookCarDetailBlock)(YLTableViewModel *model);
@interface YLLookCarDetailView : UIView

@property (nonatomic, strong) YLLookCarModel *model;
@property (nonatomic, copy) LookCarDetailBlock lookCarDetailBlock;

@end

NS_ASSUME_NONNULL_END

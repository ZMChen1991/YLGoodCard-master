//
//  YLBrandView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/26.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBrandModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BrandViewBlock)(YLBrandModel *brandModel);

@interface YLBrandView : UIView

@property (nonatomic, strong) NSMutableArray *brands;
@property (nonatomic, strong) NSMutableArray *groups;

@property (nonatomic, copy) BrandViewBlock BrandViewBlock;

@end

NS_ASSUME_NONNULL_END

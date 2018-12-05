//
//  YLCartypeView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/26.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLCarTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CarTypeBlock)(YLCarTypeModel *carTypeModel);

@interface YLCartypeView : UIView

@property (nonatomic, strong) NSMutableArray *carTypes;

@property (nonatomic, copy) CarTypeBlock carTypeBlock;

@end

NS_ASSUME_NONNULL_END

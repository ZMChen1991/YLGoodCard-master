//
//  YLDetectCenterController.h
//  YLGoodCard
//
//  Created by lm on 2018/12/4.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLDetectCenterModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DetectCenterBlock)(YLDetectCenterModel *model);
@interface YLDetectCenterController : UIViewController

@property (nonatomic, strong) NSString *city;
@property (nonatomic, copy) DetectCenterBlock detectCenterBlock;

@end

NS_ASSUME_NONNULL_END

//
//  YLDetectBrandController.h
//  YLGoodCard
//
//  Created by lm on 2018/12/4.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BrandBlock)(NSString *carType, NSString *typeId);
@interface YLDetectBrandController : UITableViewController

@property (nonatomic, copy) BrandBlock brandBlock;

@end

NS_ASSUME_NONNULL_END

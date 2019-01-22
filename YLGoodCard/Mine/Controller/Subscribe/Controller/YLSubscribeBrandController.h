//
//  YLSubscribeBrandController.h
//  YLGoodCard
//
//  Created by lm on 2019/1/18.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^BuyBrandBlock)(NSString *brand, NSString *series);

@interface YLSubscribeBrandController : UITableViewController

@property (nonatomic, copy) BuyBrandBlock buyBrandBlock;

@end

NS_ASSUME_NONNULL_END

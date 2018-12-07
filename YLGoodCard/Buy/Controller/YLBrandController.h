//
//  YLBrandController.h
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BuyBrandBlock)(NSString *brand, NSString *series);

@interface YLBrandController : UITableViewController

@property (nonatomic, copy) BuyBrandBlock buyBrandBlock;

@end

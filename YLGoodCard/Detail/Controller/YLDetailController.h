//
//  YLDetailController.h
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLTableViewModel.h"

typedef void(^myBlock)(NSString *title);

@interface YLDetailController : UIViewController

@property (nonatomic, strong) YLTableViewModel *model;

//@property (nonatomic, copy) myBlock block;

@end

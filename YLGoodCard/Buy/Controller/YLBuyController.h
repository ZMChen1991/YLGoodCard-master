//
//  YLBuyController.h
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLTitleBar.h"
#import "YLBuyConditionModel.h"

@interface YLBuyController : UIViewController

//@property (nonatomic, strong) NSString *searchTitle;
//@property (nonatomic, strong) NSString *brand;
//@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) YLTitleBar *titleBar;

//@property (nonatomic, strong) NSMutableDictionary *param;
//@property (nonatomic, strong) NSMutableDictionary *tempParam;

@property (nonatomic, strong) YLBuyConditionModel *paramModel;


@end

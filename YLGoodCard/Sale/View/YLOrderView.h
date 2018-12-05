//
//  YLOrderView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLDetectCenterModel.h"

typedef void(^OrderSaleBlock)(void);
typedef void(^ConsultBlock)(void);

@interface YLOrderView : UIView

@property (nonatomic, copy) OrderSaleBlock orderSaleBlock;
@property (nonatomic, copy) ConsultBlock consultBlock;

@end

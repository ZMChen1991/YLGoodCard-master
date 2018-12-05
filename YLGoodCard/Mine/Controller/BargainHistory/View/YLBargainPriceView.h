//
//  YLBargainPriceView.h
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BargainPriceBlock)(NSString *bargainPrice);

@interface YLBargainPriceView : UIView

@property (nonatomic, copy) BargainPriceBlock bargainPriceBlock;

@end

NS_ASSUME_NONNULL_END

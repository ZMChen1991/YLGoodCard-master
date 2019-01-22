//
//  YLSubscribePriceView.h
//  YLGoodCard
//
//  Created by lm on 2019/1/19.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^PriceBlock)(NSInteger lowPrice, NSInteger highPrice);

@interface YLSubscribePriceView : UIView

@property (nonatomic, copy) PriceBlock priceBlock;

@property (nonatomic, strong) NSString *lowPriceStr;
@property (nonatomic, strong) NSString *highPriceStr;

@end

NS_ASSUME_NONNULL_END

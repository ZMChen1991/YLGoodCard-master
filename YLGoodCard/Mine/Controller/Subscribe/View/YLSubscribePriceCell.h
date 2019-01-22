//
//  YLSubscribePriceCell.h
//  YLGoodCard
//
//  Created by lm on 2019/1/19.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PriceBlock)(NSString *lowPrice, NSString *highPrice);

@interface YLSubscribePriceCell : UICollectionViewCell

@property (nonatomic, strong) NSString *lowPrice;
@property (nonatomic, strong) NSString *highPrice;

@end

NS_ASSUME_NONNULL_END

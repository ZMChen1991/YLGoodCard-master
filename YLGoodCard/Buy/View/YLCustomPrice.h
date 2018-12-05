//
//  YLCustomPrice.h
//  YLGoodCard
//
//  Created by lm on 2018/11/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^customPriceBlock)(UIButton *sender);
@class YLCustomPrice;
@protocol YLCustomPriceDelegate <NSObject>
@optional
- (void)pushLowPrice:(NSString *)lowPrice highPrice:(NSString *)highPrice;
@end


@interface YLCustomPrice : UIView

@property (nonatomic, copy) customPriceBlock customPriceBlock;
@property (nonatomic, weak) id<YLCustomPriceDelegate> delegate;


@end

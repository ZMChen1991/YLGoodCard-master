//
//  YLDetailBargainView.h
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BargainBlock)(NSString *price);
typedef void(^CancelBlock)(void);

@interface YLDetailBargainView : UIView

@property (nonatomic, copy) BargainBlock bargainBlock;
@property (nonatomic, copy) CancelBlock cancelBlock;

@property (nonatomic, strong) NSString *salePrice;// 卖价

@end

NS_ASSUME_NONNULL_END

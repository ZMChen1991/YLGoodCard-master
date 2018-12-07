//
//  YLHotCarView.h
//  YLGoodCard
//
//  Created by lm on 2018/12/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MoreBlock)(void);
typedef void(^BrandBlock)(NSString *brand);

@interface YLHotCarView : UIView

@property (nonatomic, copy) MoreBlock moreBlock;
@property (nonatomic, copy) BrandBlock brandBlock;
@end

NS_ASSUME_NONNULL_END

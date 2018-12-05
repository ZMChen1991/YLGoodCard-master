//
//  YLNoneView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NoneViewBlock)(void);

@interface YLNoneView : UIView


@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) NoneViewBlock noneViewBlock;

@end

NS_ASSUME_NONNULL_END

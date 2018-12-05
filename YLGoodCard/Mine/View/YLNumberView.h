//
//  YLNumberView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/27.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//typedef void(^NumberBlock)(void);

@interface YLNumberView : UIView

@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *title;

//@property (nonatomic, copy) NumberBlock numberBlock;

@end

NS_ASSUME_NONNULL_END

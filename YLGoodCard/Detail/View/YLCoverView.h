//
//  YLCoverView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/9.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BargainBlock)(NSString *price);
typedef void(^TimePickerBlock)(NSString *time);

@interface YLCoverView : UIView

@property (nonatomic, strong) UIView *bargainBg;// 砍价背景
@property (nonatomic, strong) UIView *orderBg;// 预约看车背景

@property (nonatomic, copy) BargainBlock bargainBlock;
@property (nonatomic, copy) TimePickerBlock timePickerBlock;

@property (nonatomic, strong) NSString *salePrice;


@end

//
//  YLFunctionView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLNumberView.h"

@class YLFunctionView;

@protocol YLFunctionViewDelegate <NSObject>

@optional
- (void)btnClickToController:(UIButton *)sender;
- (void)callTelephone;
- (void)suggestions;
- (void)numberViewClickInIndex:(NSInteger)index;

@end

@interface YLFunctionView : UIView

@property (nonatomic, strong) NSMutableArray *numbers;// 装有4个元素：即将看车，收藏数，浏览记录，订阅数

@property (nonatomic, weak) id<YLFunctionViewDelegate> delegate;


@end

//
//  YLLinkageView.h
//  仿美团菜单栏
//
//  Created by lm on 2017/5/26.
//  Copyright © 2017年 CocaCola. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLLinkageView;

@protocol YLLinkageViewDelegate <NSObject>

@optional
- (void)pushController:(YLLinkageView *)linkageView; // 跳转控制器
- (void)pushCoverView:(UIButton *)sender;// 弹出蒙版;

@end

@interface YLLinkageView : UIView

@property (nonatomic, weak) id<YLLinkageViewDelegate> delegate;

@end

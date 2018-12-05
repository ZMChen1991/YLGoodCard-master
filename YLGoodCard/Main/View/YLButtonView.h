//
//  YLButtonView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YLButtonView;
@protocol YLButtonViewDelegate <NSObject>
@optional
- (void)selectBtnTitle:(NSString *)title;
@end

typedef void(^tapClickBlock)(UILabel *label);

@interface YLButtonView : UIView

@property (nonatomic, weak) id<YLButtonViewDelegate> delegate;
@property (nonatomic, copy) tapClickBlock tapClickBlock;

- (instancetype)initWithFrame:(CGRect)frame btnTitles:(NSArray *)btnTitles;

@end

NS_ASSUME_NONNULL_END

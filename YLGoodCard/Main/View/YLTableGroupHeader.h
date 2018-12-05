//
//  YLTableGroupHeader.h
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^labelBlock)(NSString *string);

@class YLTableGroupHeader;
@protocol YLTableGroupHeaderDelegate <NSObject>
@optional
- (void)pushBuyControl;
@end

@interface YLTableGroupHeader : UIView

@property (nonatomic, weak) id<YLTableGroupHeaderDelegate> delegate;
@property (nonatomic, copy) labelBlock labelBlock;

/**
 初始化

 @param frame frame
 @param image 标题图片
 @param title t标题
 @param detailTitle 更多详情
 @param arrowImage 箭头图片
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image title:(NSString *)title detailTitle:(NSString *)detailTitle arrowImage:(NSString *)arrowImage;

@end

NS_ASSUME_NONNULL_END

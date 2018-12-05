//
//  YLBanner.h
//  YLGoodCard
//
//  Created by lm on 2018/11/14.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLBanner : UIView

//@property (nonatomic, strong) NSMutableArray *images;

/**
 初始化

 @param frame frame
 @param images 图片数组
 @param isRunning 是否滚动
 */
- (instancetype)initWithFrame:(CGRect)frame Images:(NSMutableArray *)images isRunning:(BOOL)isRunning;

@end

NS_ASSUME_NONNULL_END

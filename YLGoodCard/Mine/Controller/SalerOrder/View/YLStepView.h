//
//  YLStepView.h
//  Block
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLStepView : UIView

@property (nonatomic, assign) NSInteger stepIndex;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@end

NS_ASSUME_NONNULL_END

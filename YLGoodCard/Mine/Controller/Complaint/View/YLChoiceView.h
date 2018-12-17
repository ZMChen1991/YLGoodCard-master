//
//  YLChoiceView.h
//  YLGoodCard
//
//  Created by lm on 2018/12/17.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChoiceQuestionlock)(NSString *title);

@interface YLChoiceView : UIView

@property (nonatomic, copy) ChoiceQuestionlock choiceQuestionlock;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END

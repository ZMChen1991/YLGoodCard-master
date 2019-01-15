//
//  YLConditionParamView.h
//  Block
//
//  Created by lm on 2018/12/18.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YLConditionParamViewDelegate <NSObject>

- (void)paramViewRemoveWithIndex:(NSInteger)index;
- (void)paramViewRemoveAllObject;

@end

typedef void(^ConditionParamBlock)(void);
typedef void(^RemoveBlock)(NSInteger index, NSString *title);

@interface YLConditionParamView : UIView

@property (nonatomic, strong) NSMutableArray *params;
@property (nonatomic, copy) ConditionParamBlock conditionParamBlock;
@property (nonatomic, copy) RemoveBlock removeBlock;
@property (nonatomic, weak) id<YLConditionParamViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

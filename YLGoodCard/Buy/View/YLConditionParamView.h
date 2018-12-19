//
//  YLConditionParamView.h
//  Block
//
//  Created by lm on 2018/12/18.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConditionParamBlock)(void);
typedef void(^RemoveBlock)(NSInteger index, NSString *title);
@interface YLConditionParamView : UIView

@property (nonatomic, strong) NSArray *params;
@property (nonatomic, copy) ConditionParamBlock conditionParamBlock;
@property (nonatomic, copy) RemoveBlock removeBlock;

@end

NS_ASSUME_NONNULL_END

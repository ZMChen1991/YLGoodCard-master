//
//  YLCollectionFooterButton.h
//  YLGoodCard
//
//  Created by lm on 2019/1/16.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YLCollectionFooterButtonDelegate <NSObject>

- (void)editorOrDelete;

@end

typedef void(^YLCollectionFooterButtonBlock)(void);

@interface YLCollectionFooterButton : UIView

@property (nonatomic, weak) id<YLCollectionFooterButtonDelegate> delegate;
@property (nonatomic, copy) YLCollectionFooterButtonBlock block;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image;

@end

NS_ASSUME_NONNULL_END

//
//  YLTitleLinkageView.h
//  Block
//
//  Created by lm on 2018/12/18.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LinkageBlock)(NSInteger index);
@protocol YLTitleLinkageViewDelegate <NSObject>

- (void)linkageWithIndex:(NSInteger)index;

@end

@interface YLTitleLinkageView : UIView

@property (nonatomic, copy) LinkageBlock linkageBlock;
//@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, assign) BOOL isRest;
@property (nonatomic, assign) BOOL isChange;
@property (nonatomic, weak) id<YLTitleLinkageViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

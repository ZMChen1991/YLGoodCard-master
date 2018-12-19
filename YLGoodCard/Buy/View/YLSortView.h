//
//  YLSortView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/10.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLSortView;

@protocol YLSortViewDelegate <NSObject>

- (void)didSelectSort:(NSInteger)index;

@end


typedef void(^SortViewBlock)(NSInteger index, NSString *title);
@interface YLSortView : UIView

@property (nonatomic, weak) id<YLSortViewDelegate> delegate;
@property (nonatomic, copy) SortViewBlock sortViewBlock;

@end

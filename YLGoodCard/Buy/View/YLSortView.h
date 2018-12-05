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

@interface YLSortView : UIView

@property (nonatomic, weak) id<YLSortViewDelegate> delegate;

@end

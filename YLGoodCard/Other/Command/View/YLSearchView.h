//
//  YLSearchView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/17.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^tapClick)(NSString *string);

@interface YLSearchView : UIView

//@property (nonatomic, strong) NSMutableArray *hotArray;

@property (nonatomic, copy) tapClick tapClick;

- (instancetype)initWithFrame:(CGRect)frame historyArray:(NSMutableArray *)historyArray hotArray:(NSMutableArray *)hotArray;
@end

NS_ASSUME_NONNULL_END

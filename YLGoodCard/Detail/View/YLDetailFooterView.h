//
//  YLDetailFooterView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLCondition.h"
#import "YLDetailModel.h"

typedef void(^CollectBlock)(BOOL isCollect);
typedef void(^CustomBlock)(void);

@interface YLDetailFooterView : UIView

@property (nonatomic, strong) YLDetailModel *model;

@property (nonatomic, strong) YLCondition *bargain;
@property (nonatomic, strong) YLCondition *order;

@property (nonatomic, copy) CollectBlock collectBlock;
@property (nonatomic, copy) CustomBlock customBlock;

//@property (nonatomic, assign) BOOL isCollect;// 是否收藏

@end

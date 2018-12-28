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

typedef void(^CollectBlock)(NSString *isCollect);
typedef void(^CustomBlock)(void);

@interface YLDetailFooterView : UIView

@property (nonatomic, strong) YLDetailModel *model;

@property (nonatomic, strong) YLCondition *bargain;
@property (nonatomic, strong) YLCondition *order;

@property (nonatomic, copy) CollectBlock collectBlock;
@property (nonatomic, copy) CustomBlock customBlock;

@property (nonatomic, strong) NSString *isCollect;// 是否收藏
@property (nonatomic, strong) NSString *isBook;// 是否预约看车

@end

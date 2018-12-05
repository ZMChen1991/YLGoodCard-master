//
//  YLDetailHeaderView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLDetailHeaderModel.h"

typedef void(^DetailHeaderBargainBlock)(void);

@interface YLDetailHeaderView : UIView


@property (nonatomic, strong) YLDetailHeaderModel *model;

@property (nonatomic, copy) DetailHeaderBargainBlock detailHeaderBargainBlock;

@end

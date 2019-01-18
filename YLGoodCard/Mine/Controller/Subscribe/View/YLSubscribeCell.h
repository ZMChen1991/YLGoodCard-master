//
//  YLSubscribeCell.h
//  YLGoodCard
//
//  Created by lm on 2019/1/16.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSubscribeCellFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLSubscribeCell : UITableViewCell


@property (nonatomic, strong) YLSubscribeCellFrame *cellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

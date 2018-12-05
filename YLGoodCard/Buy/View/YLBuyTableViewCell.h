//
//  YLBuyTableViewCell.h
//  YLGoodCard
//
//  Created by lm on 2018/11/22.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBuyCellFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLBuyTableViewCell : UITableViewCell

@property (nonatomic, strong) YLBuyCellFrame *cellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END

//
//  YLBuyOrderCell.h
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBuyOrderCellFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLBuyOrderCell : UITableViewCell

@property (nonatomic, strong) YLBuyOrderCellFrame *buyOrderCellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

//
//  YLSaleOrderCell.h
//  YLGoodCard
//
//  Created by lm on 2018/12/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSaleOrderCellFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLSaleOrderCell : UITableViewCell

@property (nonatomic, strong) YLSaleOrderCellFrame *saleOrderCellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

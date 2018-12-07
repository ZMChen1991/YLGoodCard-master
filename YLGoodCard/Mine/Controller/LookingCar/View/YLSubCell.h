//
//  YLSubCell.h
//  YLGoodCard
//
//  Created by lm on 2018/11/29.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLSubCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLSubCell : UITableViewCell

@property (nonatomic, strong) YLSubCellModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

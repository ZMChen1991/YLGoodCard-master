//
//  YLDepreciateCell.h
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLDepreciateCellFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLDepreciateCell : UITableViewCell

@property (nonatomic, strong) YLDepreciateCellFrame *cellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

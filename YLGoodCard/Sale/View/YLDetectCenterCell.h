//
//  YLDetectCenterCell.h
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLDetectCenterCellFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLDetectCenterCell : UITableViewCell

@property (nonatomic, strong) YLDetectCenterCellFrame *cellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

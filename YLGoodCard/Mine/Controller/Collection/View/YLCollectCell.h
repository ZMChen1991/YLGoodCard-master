//
//  YLCollectCell.h
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLCollectCellFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLCollectCell : UITableViewCell

@property (nonatomic, strong) YLCollectCellFrame *collectCellFrame;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

//
//  YLBargainHistoryDetailCell.h
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AccepBlock)(void);
typedef void(^DickerBlock)(void);

@interface YLBargainHistoryDetailCell : UITableViewCell

@property (nonatomic, copy) AccepBlock accepBlock;
@property (nonatomic, copy) DickerBlock dickerBlock;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

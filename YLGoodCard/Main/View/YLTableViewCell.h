//
//  YLTableViewCell.h
//  YLYouka
//
//  Created by lm on 2018/11/14.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLTableViewModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface YLTableViewCell : UITableViewCell

@property (nonatomic, strong) YLTableViewModel *model;
@property (nonatomic, assign) BOOL islargeImage;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

//
//  YLReportCell.h
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//检测报告

#import <UIKit/UIKit.h>
#import "YLDetailModel.h"

@interface YLReportCell : UITableViewCell

//@property (nonatomic, strong) NSString *remarks;
@property (nonatomic, strong) YLDetailModel *model;

+ (instancetype)cellWithTable:(UITableView *)tableView;

@end

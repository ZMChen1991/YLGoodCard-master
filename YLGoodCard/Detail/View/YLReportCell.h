//
//  YLReportCell.h
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//检测报告

#import <UIKit/UIKit.h>

@interface YLReportCell : UITableViewCell

@property (nonatomic, assign) float height;

+ (instancetype)cellWithTable:(UITableView *)tableView;

@end

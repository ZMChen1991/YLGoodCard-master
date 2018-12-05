//
//  YLCarInformationCell.h
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
// 车辆图文

#import <UIKit/UIKit.h>

@interface YLCarInformationCell : UITableViewCell


@property (nonatomic, assign) float height;// cell高

+ (instancetype)cellWithTable:(UITableView *)tableView;
@end

//
//  YLInformationCell.h
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

// 基本信息

#import <UIKit/UIKit.h>
#import "YLDetailInfoModel.h"

@interface YLInformationCell : UITableViewCell

@property (nonatomic, assign) float height;
@property (nonatomic, strong) YLDetailInfoModel *model;

+ (instancetype)cellWithTable:(UITableView *)tableView;

@end

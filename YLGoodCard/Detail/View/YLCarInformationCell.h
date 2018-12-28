//
//  YLCarInformationCell.h
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
// 车辆图文

#import <UIKit/UIKit.h>
#import "YLBlemishModel.h"

@interface YLCarInformationCell : UITableViewCell

@property (nonatomic, strong) NSArray *blemishModels;

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *blemishs;
@property (nonatomic, strong) NSArray *blemishTitles;


@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;

+ (instancetype)cellWithTable:(UITableView *)tableView;
@end

//
//  YLMessageCell.h
//  YLGoodCard
//
//  Created by lm on 2018/11/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLMessageCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *messageL;
@property (nonatomic, strong) UILabel *detailL;
@property (nonatomic, strong) UILabel *dateL;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

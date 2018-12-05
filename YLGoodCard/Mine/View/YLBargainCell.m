//
//  YLBargainCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBargainCell.h"

@interface YLBargainCell ()
@property (nonatomic, strong) YLCondition *bargainNum; // 砍价数
@end

@implementation YLBargainCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"YLBargainCell";
    YLBargainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLBargainCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.bargainNum = [[YLCondition alloc] initWithFrame:CGRectMake(YLScreenWidth-36-YLLeftMargin, 110 - 36 - YLLeftMargin, 36, 36)];
    self.bargainNum.type = YLConditionTypeWhite;
    [self.bargainNum setTitle:@"10" forState:UIControlStateNormal];
    self.bargainNum.layer.cornerRadius = 18;
    [self addSubview:self.bargainNum];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

@end

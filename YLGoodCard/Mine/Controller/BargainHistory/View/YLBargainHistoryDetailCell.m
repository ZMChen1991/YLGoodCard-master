//
//  YLBargainHistoryDetailCell.m
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBargainHistoryDetailCell.h"
#import "YLCondition.h"

@implementation YLBargainHistoryDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID =@"YLBargainHistoryDetailCell";
    YLBargainHistoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLBargainHistoryDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    YLCondition *dicker = [YLCondition buttonWithType:UIButtonTypeCustom];
    dicker.type = YLConditionTypeWhite;
    dicker.frame = CGRectMake(YLScreenWidth - 60 * 2 - 15 - 10, 10, 60, 30);
    [dicker setTitle:@"还价" forState:UIControlStateNormal];
    [dicker addTarget:self action:@selector(dicker) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dicker];
    
    YLCondition *accept = [YLCondition buttonWithType:UIButtonTypeCustom];
    accept.type = YLConditionTypeWhite;
    accept.frame = CGRectMake(YLScreenWidth - 60 - 15, 10, 60, 30);
    [accept setTitle:@"接受" forState:UIControlStateNormal];
    [accept addTarget:self action:@selector(accept) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:accept];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, 10, CGRectGetMinX(dicker.frame) - YLLeftMargin, 30)];
    title.font = [UIFont systemFontOfSize:14];
    title.text = @"13800******还价13万";
    [self addSubview:title];
}

- (void)accept {
    NSLog(@"点击接受");
    if (self.accepBlock) {
        self.accepBlock();
    }
}

- (void)dicker {
    NSLog(@"YLBargainHistoryDetailCell:点击还价");
    if (self.dickerBlock) {
        self.dickerBlock();
    }
}
@end

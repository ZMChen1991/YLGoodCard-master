//
//  YLMessageCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLMessageCell.h"

@implementation YLMessageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"cellID";
    YLMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupOriginal];
    }
    return self;
}

- (void)setupOriginal {
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = [UIColor redColor];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *messageL = [[UILabel alloc] init];
    messageL.font = [UIFont systemFontOfSize:17];
    [self addSubview:messageL];
    self.messageL = messageL;
    
    UILabel *detailL = [[UILabel alloc] init];
    detailL.font = [UIFont systemFontOfSize:15];
    [self addSubview:detailL];
    self.detailL = detailL;
    
    UILabel *dateL = [[UILabel alloc] init];
    dateL.font = [UIFont systemFontOfSize:15];
    dateL.textAlignment = NSTextAlignmentRight;
    [self addSubview:dateL];
    self.dateL = dateL;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    float horizontalMargin = 10;
    float verticalMargin = 15;
    float iconX = verticalMargin;
    float iconY = horizontalMargin;
    float iconW = self.frame.size.height - 2 * horizontalMargin;
    float iconH = iconW;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    float messageX = CGRectGetMaxX(self.iconView.frame) + horizontalMargin;
    float messageY = iconY;
    float messageW = 100;
    float messageH = iconH / 2;
    self.messageL.frame = CGRectMake(messageX, messageY, messageW, messageH);
    
    float detailX = messageX;
    float detailY = CGRectGetMaxY(self.messageL.frame);
    float detailW = messageW;
    float detailH = messageH;
    self.detailL.frame = CGRectMake(detailX, detailY, detailW, detailH);
    
    float dateX = self.frame.size.width - verticalMargin - messageW;
    float dateY = messageY;
    float dateW = messageW;
    float dateH = messageH;
    self.dateL.frame = CGRectMake(dateX, dateY, dateW, dateH);
}

@end

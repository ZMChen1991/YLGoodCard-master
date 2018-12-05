//
//  YLTableViewCell.m
//  YLYouka
//
//  Created by lm on 2018/11/14.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLTableViewCell.h"
#import "YLCommandCellView.h"


@interface YLTableViewCell ()
@property (nonatomic, strong) YLCommandCellView *cellView;
@end

@implementation YLTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"YLTableViewCell";
    YLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        YLCommandCellView *cellView = [[YLCommandCellView alloc] init];
        cellView.frame = self.bounds;
        if (self.islargeImage) {
            cellView.isSmallImage = NO;
        } else {
            cellView.isSmallImage = YES;
        }
        [self addSubview:cellView];
        self.cellView = cellView;
    }
    return self;
}

- (void)setModel:(YLTableViewModel *)model {
    
    _model = model;
    self.cellView.model = model;
}

// cell获取的宽不对，这里重设宽
- (void)setFrame:(CGRect)frame {
    frame.size.width = YLScreenWidth;
    [super setFrame:frame];
}

@end

//
//  YLSaleCarChoiceCell.m
//  YLFunction
//
//  Created by lm on 2019/1/21.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLSaleCarChoiceCell.h"

@interface YLSaleCarChoiceCell ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation YLSaleCarChoiceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *const cellID = @"YLSaleCarChoiceCell";
    YLSaleCarChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YLSaleCarChoiceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = YLColor(51.f, 51.f, 51.f);
        [self addSubview:titleLabel];
        self.label = titleLabel;
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.textColor = YLColor(51.f, 51.f, 51.f);
        [detailLabel setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [detailLabel addGestureRecognizer:tap];
        [self addSubview:detailLabel];
        self.detailLabel = detailLabel;
    }
    return self;
}

- (void)tap {
    if (self.choiceBlock) {
        self.choiceBlock();
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    CGSize titleSize = [title getSizeWithFont:[UIFont systemFontOfSize:14]];
    self.label.frame = CGRectMake(15, 0, titleSize.width, self.frame.size.height);
    self.label.text = title;
}

- (void)setDetailTitle:(NSString *)detailTitle {
    _detailTitle = detailTitle;
    
    CGSize titleSize = [detailTitle getSizeWithFont:[UIFont systemFontOfSize:14]];
    CGFloat titleW = (YLScreenWidth - 2 * YLLeftMargin)/ 2;
    if (titleSize.width > titleW ) {
        self.detailLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - titleW, 0, titleW, self.frame.size.height);
    } else {
        self.detailLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - titleSize.width, 0, titleSize.width, self.frame.size.height);
    }
    self.detailLabel.text = detailTitle;
}

@end

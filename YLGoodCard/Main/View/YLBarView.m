//
//  YLBarView.m
//  Block
//
//  Created by lm on 2018/12/21.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBarView.h"

@interface YLBarView ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation YLBarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupUI {
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 15, 15)];
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame) + 10, 0, self.frame.size.width - 15 - 5, self.frame.size.height)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
    self.label = label;
}

- (void)tap:(UITapGestureRecognizer *)sender {
    if (self.barViewBlock) {
        self.barViewBlock();
    }
}

- (void)setIcon:(NSString *)icon {
    _icon = [icon copy];
    self.iconView.image = [UIImage imageNamed:icon];
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.label.text = title;
}

@end

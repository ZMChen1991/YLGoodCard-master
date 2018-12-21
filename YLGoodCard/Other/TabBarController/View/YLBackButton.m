//
//  YLBackButton.m
//  Block
//
//  Created by lm on 2018/12/21.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBackButton.h"

@interface YLBackButton ()

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation YLBackButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if (self.backBlock) {
        self.backBlock();
    }
}

- (void)setupUI {
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (44 - 20) / 2, 10, 20)];
    iconView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:iconView];
    self.iconView = iconView;
}

- (void)setIcon:(NSString *)icon {
    _icon = icon;
    self.iconView.image = [UIImage imageNamed:icon];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}
@end

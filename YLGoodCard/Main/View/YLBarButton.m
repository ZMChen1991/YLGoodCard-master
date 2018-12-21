//
//  YLBarButton.m
//  Block
//
//  Created by lm on 2018/12/21.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBarButton.h"
@interface YLBarButton ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation YLBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    label.textColor = [UIColor whiteColor];
//    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
    self.label = label;
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 3, (44 - 6) / 2, 12, 6)];
    icon.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:icon];
    self.iconView = icon;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.label.text = title;
}

- (void)setIcon:(NSString *)icon {
    _icon = [icon copy];
    self.iconView.image = [UIImage imageNamed:icon];
}

@end

//
//  YLTableGroupHeader.m
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLTableGroupHeader.h"

@interface YLTableGroupHeader ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailTitleLabel;
@property (nonatomic, strong) UIImageView *arrowIcon;
@property (nonatomic, strong) UIView *view;
//@property (nonatomic, strong) UIView *line;

@end

@implementation YLTableGroupHeader

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image title:(NSString *)title detailTitle:(NSString *)detailTitle arrowImage:(NSString *)arrowImage {
    
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *icon = [[UIImageView alloc] init];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        icon.image = [UIImage imageNamed:image];
        [self addSubview:icon];
        self.icon = icon;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = [UIColor redColor];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
        self.view = view;
        
        UILabel *detailTitleLabel = [[UILabel alloc] init];
        detailTitleLabel.text = detailTitle;
        detailTitleLabel.textColor = YLColor(155.f, 155.f, 155.f);
        detailTitleLabel.textAlignment = NSTextAlignmentRight;
        detailTitleLabel.font = [UIFont systemFontOfSize:12];
//        detailTitleLabel.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
//        [detailTitleLabel addGestureRecognizer:tap];
        [view addSubview:detailTitleLabel];
        self.detailTitleLabel = detailTitleLabel;
        
        UIImageView *arrowIcon = [[UIImageView alloc] init];
        arrowIcon.image = [UIImage imageNamed:arrowImage];
//        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
//        [arrowIcon addGestureRecognizer:tap];
//        [arrowIcon setUserInteractionEnabled:YES];
        [view addSubview:arrowIcon];
        self.arrowIcon = arrowIcon;
        
    }
    return self;
}

- (void)labelClick:(UITapGestureRecognizer *)tap {

    if (self.delegate && [self.delegate respondsToSelector:@selector(pushBuyControl)]) {
        [self.delegate pushBuyControl];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushMoreControl)]) {
        [self.delegate pushMoreControl];
    }
}

// 判断字符串是否为空或者空格符
-  (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat iconH = height - 2 * YLTopMargin;
    CGFloat titleW = width / 3;
    self.icon.frame = CGRectMake(YLLeftMargin, YLTopMargin, 20, iconH);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.icon.frame) + 5, YLTopMargin, titleW, iconH);
    
    self.view.frame = CGRectMake(width - YLTopMargin - titleW / 2, YLTopMargin , titleW / 2, iconH);
    self.detailTitleLabel.frame = CGRectMake(0, 0, titleW / 2 - 12, iconH);
    self.arrowIcon.frame = CGRectMake(CGRectGetMaxX(self.detailTitleLabel.frame) + 5, 5, 7, iconH/2);
//    self.arrowIcon.frame = CGRectMake(width - YLTopMargin - 10 - 5, YLTopMargin  + 6, 7, iconH/2);
//    self.detailTitleLabel.frame = CGRectMake(CGRectGetMidX(self.arrowIcon.frame) - titleW - 10, YLTopMargin + 1, titleW, iconH);
    
}

@end

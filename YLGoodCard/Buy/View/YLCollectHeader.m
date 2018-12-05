//
//  YLCollectHeader.m
//  HomeCollectionView
//
//  Created by lm on 2018/11/10.
//  Copyright © 2018 CocaCola. All rights reserved.
//
// RGB颜色
#define YLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define YLRandomColor YLColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#import "YLCollectHeader.h"

@interface YLCollectHeader ()



@end

@implementation YLCollectHeader

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.title.frame = CGRectMake(15, 0, self.frame.size.width * 0.8, self.frame.size.height);
    self.detailTitle.frame = CGRectMake(0 + self.frame.size.width * 0.8, 0, self.frame.size.width * 0.2 - 15, self.frame.size.height);
}

- (void)setupUI {
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"排量(单位:万公里)";
    title.font = [UIFont systemFontOfSize:14];
    title.textColor = YLColor(51.0, 51.0, 51.0);
    title.textAlignment = NSTextAlignmentLeft;
    [self addSubview:title];
    self.title = title;
    
    UILabel *detailTitle = [[UILabel alloc] init];
    detailTitle.text = @"更多";
    detailTitle.font = [UIFont systemFontOfSize:14];
    detailTitle.textColor = YLColor(155.0, 155.0, 155.0);
    detailTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:detailTitle];
    self.detailTitle = detailTitle;
}

@end

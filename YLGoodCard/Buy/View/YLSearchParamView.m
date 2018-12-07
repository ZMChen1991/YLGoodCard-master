//
//  YLSearchParamView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSearchParamView.h"

@implementation YLSearchParamView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setupUI {
    
    if (!self.titles.count) {
        return;
    }
    
    CGFloat labelY = 5;
    CGFloat labelX = 5;
    CGFloat labelH = 20;
    for (NSInteger i = 0; i < self.titles.count; i++) {
        CGSize labelSize =[self.titles[i] getSizeWithFont:[UIFont systemFontOfSize:12]];
        CGFloat labelW = labelSize.width + 30;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        label.layer.borderWidth = 0.5f;
        label.layer.cornerRadius = 4.f;
        label.layer.masksToBounds = YES;
        label.text = self.titles[i];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        labelX = labelX + labelW + 10;
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

- (void)setTitles:(NSMutableArray *)titles {
    _titles = titles;
    [[self subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setupUI];
}

@end

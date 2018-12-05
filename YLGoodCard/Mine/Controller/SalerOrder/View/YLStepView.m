//
//  YLStepView.m
//  Block
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLStepView.h"

@interface YLStepView ()

@property (nonatomic, strong) NSMutableArray *cricleMarks;
@property (nonatomic, strong) NSMutableArray *titleLabels;
@property (nonatomic, strong) UIView *unProgressBar;
@property (nonatomic, strong) UIView *progressBar;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation YLStepView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titles = titles;
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    // 进度条
    UIView *unProgressBar = [[UIView alloc] init];
    unProgressBar.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:unProgressBar];
    self.unProgressBar = unProgressBar;
    
    // 进行过的进度条
    UIView *progressBar = [[UIView alloc] init];
    progressBar.backgroundColor = [UIColor redColor];
    [self addSubview:progressBar];
    self.progressBar = progressBar;
    
    for (NSString *title in self.titles) {
        // 标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:titleLabel];
        [self.titleLabels addObject:titleLabel];
        
        // 圆点
        UIView *cricle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
        cricle.backgroundColor = [UIColor lightGrayColor];
        cricle.layer.cornerRadius = 13.f / 2;
        cricle.layer.masksToBounds = YES;
        [self addSubview:cricle];
        [self.cricleMarks addObject:cricle];
    }
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat titleLabelW = self.frame.size.width / self.titleLabels.count;
    self.unProgressBar.frame = CGRectMake(titleLabelW / 2, 20, self.frame.size.width - titleLabelW, 3);
    
    CGFloat unProgressBarX = self.unProgressBar.frame.origin.x;
    for (NSInteger i = 0; i < self.titles.count; i++) {
        UIView *cricle = self.cricleMarks[i];
        cricle.center = CGPointMake(i * titleLabelW + unProgressBarX, self.unProgressBar.center.y);
        
        UILabel *titleLabel = self.titleLabels[i];
        titleLabel.frame = CGRectMake(i * titleLabelW, CGRectGetMaxY(cricle.frame) + 15, titleLabelW, 20);
    }
}

- (void)setStepIndex:(NSInteger)stepIndex {
    
    CGFloat titleLabelW = self.frame.size.width / self.titleLabels.count;
    self.progressBar.frame = CGRectMake(titleLabelW / 2, 20, titleLabelW * stepIndex, 3);
    
    for (NSInteger i = 0; i < self.titles.count; i++) {
        UIView *cricle = self.cricleMarks[i];
        if (i <= stepIndex) {
            cricle.backgroundColor = [UIColor redColor];
        } else {
            cricle.backgroundColor = [UIColor lightGrayColor];
        }
        
        UILabel *titleLabel = self.titleLabels[i];
        if (i <= stepIndex) {
            titleLabel.textColor = [UIColor redColor];
        } else {
            titleLabel.textColor = [UIColor lightGrayColor];
        }
    }
    
}


- (NSMutableArray *)titleLabels {
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (NSMutableArray *)cricleMarks {
    if (!_cricleMarks) {
        _cricleMarks = [NSMutableArray array];
    }
    return _cricleMarks;
}

@end

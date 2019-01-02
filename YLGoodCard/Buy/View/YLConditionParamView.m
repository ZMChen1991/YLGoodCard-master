//
//  YLConditionParamView.m
//  Block
//
//  Created by lm on 2018/12/18.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLConditionParamView.h"

@interface YLConditionParamView ()

@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) NSMutableArray *titles;

@end

@implementation YLConditionParamView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setUserInteractionEnabled:YES];
//        self.backgroundColor = YLColor(233.f, 233.f, 233.f);
        self.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        label.backgroundColor = YLColor(233.f, 233.f, 233.f);
        [self addSubview:label];
    }
    return self;
}

- (void)setupUI {
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth - 70, self.frame.size.height)];
//    scroll.backgroundColor = YLColor(233.f, 233.f, 233.f);
    scroll.backgroundColor = [UIColor whiteColor];
    [self addSubview:scroll];
    self.scroll = scroll;
    
//    UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
//    delete.frame = CGRectMake(CGRectGetMaxX(scroll.frame) + 10, 0, 50, self.frame.size.height);
//    delete.backgroundColor = [UIColor whiteColor];
//    delete.titleLabel.font = [UIFont systemFontOfSize:14];
//    [delete setTitle:@"重置" forState:UIControlStateNormal];
//    [delete setTitleColor:YLColor(155.f, 155.f, 155.f) forState:UIControlStateNormal];
//    [delete addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:delete];
    
//    UIView *deleteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, self.frame.size.height)];
    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.backgroundColor = [UIColor redColor];
    imageView.frame = CGRectMake(CGRectGetMaxX(scroll.frame) + 10, 17, 43, self.frame.size.height - 34);
    imageView.image = [UIImage imageNamed:@"重置"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [imageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteClick)];
    [imageView addGestureRecognizer:tap];
    [self addSubview:imageView];
}

#pragma mark 清空参数label
- (void)deleteClick {
    
    [self.titles removeAllObjects];
    [self.scroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSLog(@"清空字符串%@", self.titles);
    if (self.conditionParamBlock) {
        self.conditionParamBlock();
    }
}

#pragma mark 删除点击的参数label
- (void)labelClick:(UITapGestureRecognizer *)tap {
    UILabel *label = (UILabel *)tap.view;
    NSInteger tag = label.tag - 100;
    NSLog(@"点击了第%ld个label", tag);
    if (self.removeBlock) {
        self.removeBlock(tag, self.titles[tag]);
    }
    NSLog(@"self.titles.count:%@", self.titles);
    [self.titles removeObjectAtIndex:tag];
    [self refreshScrollView];
}

#pragma mark 刷新视图
- (void)refreshScrollView {
    
    if (!self.titles.count) {// 参数没有
        if (self.conditionParamBlock) {
            self.conditionParamBlock();
        }
    }
    
    [self.scroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat labelX = 10;
    CGFloat labelH = self.scroll.frame.size.height;
    for (NSInteger i = 0; i < self.titles.count; i++) {
        CGSize size = [self getSizeWithString:self.titles[i] font:[UIFont systemFontOfSize:14]];
        // 如果label背景出现一条竖线，可能是宽度没有取整导致的，使用ceil函数去精
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 9, ceilf(size.width + 30), labelH - 18)];
        label.text = self.titles[i];
        label.textColor = YLColor(51.f, 51.f, 51.f);
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = YLColor(245.f, 245.f, 245.f);
//        label.clipsToBounds = NO;
//        label.layer.masksToBounds = YES;
//        label.layer.cornerRadius = 10.f;
        label.tag = 100 + i;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
        tap.numberOfTapsRequired = 1;
        [label addGestureRecognizer:tap];
        [self.scroll addSubview:label];
        labelX += size.width + 40;
        self.scroll.contentSize = CGSizeMake(labelX, self.scroll.frame.size.height);
    }
}

// 获取字符串长度
- (CGSize)getSizeWithString:(NSString *)string font:(UIFont *)font {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (void)setParams:(NSArray *)params {
    _params = params;
    self.titles = [NSMutableArray arrayWithArray:params];
    [self refreshScrollView];
}

- (NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}
@end

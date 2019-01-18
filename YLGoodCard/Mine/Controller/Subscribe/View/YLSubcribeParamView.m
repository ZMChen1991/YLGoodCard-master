//
//  YLSubcribeParamView.m
//  YLGoodCard
//
//  Created by lm on 2019/1/16.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLSubcribeParamView.h"
#import "YLBuyConditionModel.h"

@interface YLSubcribeParamView ()

@property (nonatomic, strong) UIScrollView *scroll;

@end

@implementation YLSubcribeParamView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
        scroll.backgroundColor = [UIColor whiteColor];
        scroll.showsHorizontalScrollIndicator = NO;
        [self addSubview:scroll];
        self.scroll = scroll;
    }
    return self;
}

//- (void)setupUI {
//    
//    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    scroll.backgroundColor = [UIColor redColor];
//    [self addSubview:scroll];
//    self.scroll = scroll;
//}

#pragma mark 删除点击的参数label
- (void)labelClick:(UITapGestureRecognizer *)tap {
    UILabel *label = (UILabel *)tap.view;
    NSInteger tag = label.tag - 100;
    NSLog(@"点击了第%ld个label", tag);
    // 将选中的条件设置为不选中状态
}

#pragma mark 刷新视图
- (void)refreshScrollView {
    
    if (self.params.count == 0) {
        return;
    }
    // 移除所有的子视图
    [self.scroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat labelX = 0;
    CGFloat labelH = self.scroll.frame.size.height;
    for (NSInteger i = 0; i < self.params.count; i++) {
        YLBuyConditionModel *model = self.params[i];
        CGSize size = [self getSizeWithString:model.title font:[UIFont systemFontOfSize:14]];
        // 如果label背景出现一条竖线，可能是宽度没有取整导致的，使用ceil函数去精
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 9, ceilf(size.width + 30), labelH - 18)];
        label.text = model.title;
        label.textColor = YLColor(51.f, 51.f, 51.f);
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = YLColor(245.f, 245.f, 245.f);
        label.tag = 100 + i;
//        label.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
//        tap.numberOfTapsRequired = 1;
//        [label addGestureRecognizer:tap];
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
    [self refreshScrollView];
}

@end

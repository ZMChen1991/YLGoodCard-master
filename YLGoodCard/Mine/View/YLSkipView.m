//
//  YLSkipView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSkipView.h"

#define TITLEHEIGHT 50

@interface YLSkipView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray<UIButton *> *btns; // 存放title按钮
@property (nonatomic, strong) NSMutableArray<UIView *> *contrlViews; // 存放控制器视图
@property (nonatomic, strong) UIScrollView *controllersScroll; // 滚动视图
@property (nonatomic, strong) UIButton *selectBtn;// 选中的按钮


@end

@implementation YLSkipView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setupTitle:(NSArray *)titles {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, TITLEHEIGHT)];
    
    NSInteger width = self.frame.size.width / titles.count;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.frame = CGRectMake(width * i, 0, width, TITLEHEIGHT);
        [btn setTitleColor:YLColor(51.f, 51.f, 51.f) forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            [btn setTitleColor:YLColor(8.f, 169.f, 255.f) forState:UIControlStateNormal];
            self.selectBtn = btn;
        }
        [view addSubview:btn];
        [self.btns addObject:btn];
    }
    [self addSubview:view];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, TITLEHEIGHT, self.frame.size.width, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
}

- (void)setupScroll:(NSArray *)controllers {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TITLEHEIGHT+1, self.frame.size.width, self.frame.size.height - TITLEHEIGHT)];
    //    scrollView.backgroundColor = [UIColor redColor];
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.frame.size.width * controllers.count, self.frame.size.height - TITLEHEIGHT);
    [self addSubview:scrollView];
    self.controllersScroll = scrollView;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

- (void)selectBtn:(UIButton *)sender {

//    // 如果选中其他的按钮，默认按钮修改回原来的颜色
//    [self.selectBtn setTitleColor:YLColor(51.f, 51.f, 51.f) forState:UIControlStateNormal];
    NSInteger index = sender.tag - 100;
    [self scrollViewSelectToIndex:index];
    
}

- (void)scrollViewSelectToIndex:(NSInteger)index {
    
    // 如果选中其他的按钮，默认按钮修改回原来的颜色
    [self.selectBtn setTitleColor:YLColor(51.f, 51.f, 51.f) forState:UIControlStateNormal];
    // 设置选中的按钮
    self.selectBtn = self.btns[index];
    [self.selectBtn setTitleColor:YLColor(8.f, 169.f, 255.f) forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.controllersScroll.contentOffset = CGPointMake(self.frame.size.width * index, 0);
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint point = scrollView.contentOffset;
    NSInteger index = point.x / self.frame.size.width;
    [self scrollViewSelectToIndex:index];
}

- (NSMutableArray<UIButton *> *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)setTitles:(NSArray *)titles {
    
    _titles = titles;
    [self setupTitle:titles];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *btn = self.btns[i];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
    }
    
}

- (void)setControllers:(NSMutableArray *)controllers {
    _controllers = controllers;
    [self setupScroll:controllers];
    for (NSInteger i = 0; i < controllers.count; i++) {
        UIViewController *controller = controllers[i];
        controller.view.frame = CGRectMake(self.frame.size.width * i , 0, self.frame.size.width, self.frame.size.height - TITLEHEIGHT);
        [self.controllersScroll addSubview:controller.view];
    }
    
}

@end

//
//  YLBanner.m
//  YLGoodCard
//
//  Created by lm on 2018/11/14.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBanner.h"

@interface YLBanner () <UIScrollViewDelegate> {
    
    NSInteger _currentPage;// 当前页
    NSTimer *_timer;
}

@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat width;// 宽
@property (nonatomic, assign) CGFloat height;// 高
@property (nonatomic, strong) NSMutableArray *images; // 图片数组
@property (nonatomic, assign) BOOL isRunnning;// 是否滚动

@end

@implementation YLBanner

- (instancetype)initWithFrame:(CGRect)frame Images:(NSMutableArray *)images isRunning:(BOOL)isRunning {
    
    self = [super initWithFrame:frame];
    if (self) {
        _width = self.frame.size.width;
        _height = self.frame.size.height;
//        self.images = [NSMutableArray arrayWithArray:images];
//        // 在图片数据尾部添加原数组的第一个元素
//        [self.images addObject:[images firstObject]];
//        // 在数组中首部添加原数组最后一个元素
//        [self.images insertObject:[images lastObject] atIndex:0];
        
        self.isRunnning = isRunning;
        _currentPage = 0;
        
        [self createScroll];
        [self createPageControl];
        [self createTimer];
    }
    return self;
}

- (void)createScroll {
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    _scroll.contentSize = CGSizeMake(_width * self.images.count, _height);
    for (NSInteger i = 0; i < self.images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_width * i, 0, _width, _height)];
        [imageView sd_setImageWithURL:self.images[i] placeholderImage:nil];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        [_scroll addSubview:imageView];
    }
    _scroll.showsHorizontalScrollIndicator = NO;// 水平指示条不显示
    _scroll.bounces = NO;// 关闭弹簧效果
    _scroll.contentOffset = CGPointMake(_width, 0);// 设置用户看到第一张
    _scroll.delegate = self;
    _scroll.pagingEnabled = YES;
    [self addSubview:_scroll];
    
}

- (void)createPageControl {
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_width-200, _height-30, 100, 30)];
    _pageControl.centerX = _width / 2;
    _pageControl.numberOfPages = self.images.count - 2;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.userInteractionEnabled = NO;
    [self addSubview:_pageControl];
}

// 点击事件
- (void)tap:(UITapGestureRecognizer *)tap {
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (_timer) {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    }
    // 第一张图的位置
    CGPoint point = _scroll.contentOffset;
    if (point.x == (self.images.count - 1) * _width) {
        scrollView.contentOffset = CGPointMake(_width, 0);
    }
    if (point.x == 0) {
        scrollView.contentOffset = CGPointMake((self.images.count - 2) * _width, 0);
    }
    
    CGPoint endPoint = scrollView.contentOffset;
    _currentPage = endPoint.x / _width;
    _pageControl.currentPage = _currentPage - 1;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (_timer) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)createTimer {
    
    if (_isRunnning == YES) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(change) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)change {
    // 获得当前的点
    CGPoint point = _scroll.contentOffset;
    // 求得将要变换的点
    CGPoint endPoint = CGPointMake(point.x + _width, 0);
    // 判断
    if (endPoint.x == (self.images.count - 1) * _width) {
        [UIView animateWithDuration:0.25 animations:^{
            _scroll.contentOffset = CGPointMake(endPoint.x, 0);
        } completion:^(BOOL finished) {
            self.scroll.contentOffset = CGPointMake(self.width, 0);
            CGPoint realEnd = _scroll.contentOffset;
            _currentPage = realEnd.x /_width;
            _pageControl.currentPage = _currentPage - 1;
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            _scroll.contentOffset = endPoint;
        } completion:^(BOOL finished) {
            CGPoint realEnd = _scroll.contentOffset;
            _currentPage = realEnd.x /_width;
            _pageControl.currentPage = _currentPage - 1;
        }];
    }
}

- (NSMutableArray *)images {
    
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}
@end

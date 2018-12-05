//
//  YLBannerView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBannerView.h"

@interface YLBannerView () <UIScrollViewDelegate>

//@property (nonatomic, strong) UIScrollView *scrollView;
//// 左中右三个视图
//@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
//@property (nonatomic, strong) UIImageView *rightImageView;
//
//@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;// 定时器
@property (nonatomic, assign) NSInteger currentPage;// 当前页数
@end

@implementation YLBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setupUI {
    
    CGFloat viewW = YLScreenWidth;
    CGFloat viewH = 220;
    
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH)];
//    scrollView.contentSize = CGSizeMake(viewW * 3, viewH);
//    scrollView.contentOffset = CGPointMake(viewW, 0); // 显示中间View
//    scrollView.showsHorizontalScrollIndicator = NO;
//    scrollView.showsVerticalScrollIndicator = NO;
//    scrollView.delegate = self;
//    [self addSubview:scrollView];
//    self.scrollView = scrollView;
//
//    UIImageView *leftImageView = [[UIImageView alloc] init];
//    leftImageView.frame = CGRectMake(viewW * 0, 0, viewW, viewH);
//    [scrollView addSubview:leftImageView];
//    self.leftImageView = leftImageView;
    
    UIImageView *middleImageView = [[UIImageView alloc] init];
    middleImageView.frame = CGRectMake(0, 0, viewW, viewH);
    middleImageView.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:middleImageView];
    self.middleImageView = middleImageView;
    
//    UIImageView *rightImageView = [[UIImageView alloc] init];
//    rightImageView.frame = CGRectMake(viewW * 2, 0, viewW, viewH);
//    [scrollView addSubview:rightImageView];
//    self.rightImageView = rightImageView;
    
//    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, viewH - 20, viewW, 20)];
//    pageControl.numberOfPages = self.banners.count;
//    pageControl.currentPage = _currentPage;
//    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
//    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
//    [self addSubview:pageControl];
//    self.pageControl = pageControl;
    
//    self.currentPage = 0;// 默认是第一张图片
//    NSInteger index = self.banners.count - 1;
//    [self.leftImageView sd_setImageWithURL:self.banners[index] placeholderImage:nil];
//    [self.middleImageView sd_setImageWithURL:self.banners[0] placeholderImage:nil];
//    [self.rightImageView sd_setImageWithURL:self.banners[index + 1] placeholderImage:nil];
    // 默认显示的是中间View
    
//    leftImageView.backgroundColor = YLRandomColor;
//    middleImageView.backgroundColor = YLRandomColor;
//    rightImageView.backgroundColor = YLRandomColor;
}

#pragma mark UIScrollViewDelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    // 拖拽的时候需要暂停定时器，以免在拖拽过程中出现轮转
//    [self resumeTimer];
//}
//
//// 停止减速的时候执行
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    
//    CGPoint contentOffset = scrollView.contentOffset;
//    [self changeCurrent:contentOffset];
//    // 减速结束的时候开启定时器
//    [self addTimerLoop];
//}
//
//// 停止拖拽的时候执行
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    
//    CGPoint contentOffset = scrollView.contentOffset;
//    [self changeCurrent:contentOffset];
//    
//    // 结束拖拽的时候开启定时器
//    [self addTimerLoop];
//}

#pragma maark 视图切换
//- (void)changeCurrent:(CGPoint)contentOffset {
//
//    CGFloat viewW = self.frame.size.width;
//    // 停止拖拽的时候还原ScrollView的偏移量
//    self.scrollView.contentOffset = CGPointMake(viewW, 0);
//
//    // 当拖拽的位置大于视图一半的时候，应该切换图片，否则还是保留原来的图片
//    if (contentOffset.x > viewW + viewW / 2) { // 向 <-- 拖拽视图超过一半
//        self.currentPage++;
//        // 如果是最后的图片，让其成为第一个
//        if (self.currentPage >= self.banners.count) {
//            self.currentPage = 0;
//        }
//        NSLog(@"切换下一张:%ld", self.currentPage);
//    } else if (contentOffset.x < viewW / 2) {// 向 --> 拖拽视图超过一半
//        self.currentPage--;
//        // 如果是开始的图片，让其成为最后一个
//        if (self.currentPage < 0) {
//            self.currentPage = self.banners.count - 1;
//        }
//        NSLog(@"切换上一张:%ld", self.currentPage);
//    } else {
//        NSLog(@"不变:%ld", self.currentPage);
//    }
//    [self showImageView:self.currentPage];
//}

#pragma mark 添加定时器
- (void)addTimerLoop {
    
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(changeContentOffset) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}

#pragma mark 暂停定时器
- (void)resumeTimer {
    
    // 释放定时器
    [self.timer invalidate];
    self.timer = nil;
    
}

#pragma mark 私有方法
- (void)changeContentOffset {
    
    self.currentPage++;
    // 如果是最后的图片，让其成为第一个
    if (self.currentPage >= self.banners.count) {
        self.currentPage = 0;
    }
    [self showImageView:self.currentPage];
}

- (void)showImageView:(NSInteger)currentPage {
    
//    NSInteger down = currentPage + 1;
//    NSInteger up = currentPage - 1;
//    // 如果是最后的图片，让其成为第一个
//    if (down >= self.banners.count) {
//        down = 0;
//    }
//    // 如果是开始的图片，让其成为最后一个
//    if (up < 0) {
//        up = self.banners.count - 1;
//    }
//    NSLog(@"%ld--self.banners:%@", currentPage, self.banners);
    [self.middleImageView sd_setImageWithURL:self.banners[currentPage] placeholderImage:nil];
//    self.pageControl.currentPage = currentPage;
}

#pragma mark setter
- (void)setBanners:(NSMutableArray *)banners {
    _banners = banners;
    [self setupUI];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    
    _timeInterval = timeInterval;
    [self addTimerLoop];
}
@end

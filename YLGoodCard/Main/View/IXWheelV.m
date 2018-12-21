//
//  IXWheelV.m
//  FXApp
//
//  Created by Seven on 2017/7/17.
//  Copyright © 2017年 wsz. All rights reserved.
//

#import "IXWheelV.h"
#import "UIImageView+AFNetworking.h"

static  NSString    * cellIdent = @"collection_cell";

@interface IXWheelV ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) UICollectionView  * collectionV;
@property (nonatomic, strong) NSTimer   * wheelTimer;
@property (nonatomic, strong) UIPageControl * pageControl;
@property (nonatomic, strong) NSMutableArray    * operationArr;
@property (nonatomic, strong) NSArray   * oriItems;
@property (nonatomic, assign) BOOL  stoped;

@end

@implementation IXWheelV

- (void)dealloc
{
    NSLog(@" -- %s --",__func__);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _stoped = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionV];
        [self addSubview:self.pageControl];
        self.collectionV.contentOffset = CGPointMake(frame.size.width, 0);
        _timeSpace = 4.f;
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    _oriItems = [items copy];
    if (items.count > 1) {
        NSMutableArray  * arr = [items mutableCopy];
        [arr addObject:[[items firstObject] copy]];
        [arr insertObject:[items lastObject] atIndex:0];
        _items = arr;
        
        self.pageControl.numberOfPages = items.count;
        [self.collectionV reloadData];
        [self delayFireTimer];
    } else {
        _items = [items copy];
        [self.collectionV reloadData];
    }
}

- (void)stop
{
    _stoped = YES;
    if (_wheelTimer) {
        [_wheelTimer timeInterval];
        [_wheelTimer invalidate];
        _wheelTimer = nil;
    }

    for (NSInvocationOperation * op in self.operationArr) {
        [op cancel];
    }
    [self.operationArr removeAllObjects];
}

- (void)setTimeSpace:(CGFloat)timeSpace
{
    _timeSpace = timeSpace;
    if (_wheelTimer) {
        [_wheelTimer invalidate];
        _wheelTimer = nil;
    }

    [self delayFireTimer];
}

- (void)delayFireTimer
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_timeSpace * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.wheelTimer fire];
    });
}

- (void)fireTimer
{
    [self.wheelTimer fire];
}

- (void)changePage
{
    CGFloat x = self.collectionV.contentOffset.x;
    NSInteger   aimIndex = ((NSInteger)(x/self.bounds.size.width) + 1)% self.items.count;
    x = aimIndex * self.bounds.size.width;
    
    [self.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:aimIndex inSection:0]
                             atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                     animated:YES];
    self.pageControl.currentPage = (aimIndex-1)%(self.items.count - 2);
    if (aimIndex == self.items.count-1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionV setContentOffset:CGPointMake(self.bounds.size.width, 0)];
        });
    } else if (aimIndex == 0) {
        [self.collectionV setContentOffset:CGPointMake(self.bounds.size.width*(_items.count-1), 0)];
    }
}

#pragma mark -
#pragma mark - collection view

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IXWheelCell    * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdent
                                                                               forIndexPath:indexPath];
    
    cell.imgPath = self.items[indexPath.row];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //点击处理
    IXWheelCell    * cell = (IXWheelCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
//    if (self.selectBlk) {
//        self.selectBlk([_oriItems indexOfObject:cell.imgPath]);
//    }
    
    if (self.bannerBlock) {
        self.bannerBlock();
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat w = self.bounds.size.width;
    
    //page control
    if (targetContentOffset->x <= 0.f) {
        self.pageControl.currentPage = _items.count - 2;
    }else if (targetContentOffset->x >= w*(_items.count - 1)) {
        self.pageControl.currentPage = 0;
    }else {
        self.pageControl.currentPage = targetContentOffset->x / self.frame.size.width - 1;
    }
    
    self.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.userInteractionEnabled = YES;
    CGFloat w = self.bounds.size.width;
    if (scrollView.contentOffset.x <= 0.f) {
        CGPoint p = CGPointMake(w*(_items.count - 2), 0);
        [scrollView setContentOffset:p animated:NO];
    }else if (scrollView.contentOffset.x >= w*(_items.count - 1)) {
        CGPoint p = CGPointMake(w, 0);
        [scrollView setContentOffset:p animated:NO];
    }
    
    for (NSInvocationOperation * op in self.operationArr) {
        [op cancel];
    }
    NSInvocationOperation   * op = [[NSInvocationOperation alloc] initWithTarget:self
                                                                        selector:@selector(fireTimer)
                                                                          object:nil];
    [self.operationArr addObject:op];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_timeSpace * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!op.isCancelled) {
            [op start];
            [self.operationArr removeAllObjects];
        }
    });
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_wheelTimer invalidate];
    _wheelTimer = nil;
}

#pragma mark -
#pragma mark - lazy loading

- (UICollectionView *)collectionV
{
    if (!_collectionV) {
        UICollectionViewFlowLayout  * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.itemSize = self.bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionV = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.pagingEnabled = YES;
        _collectionV.bounces = NO;
        _collectionV.showsHorizontalScrollIndicator = NO;
        [_collectionV registerClass:[IXWheelCell class] forCellWithReuseIdentifier:cellIdent];
    }
    return _collectionV;
}

- (NSTimer *)wheelTimer
{
    if (!_wheelTimer) {
        if (_stoped) {
            return nil;
        }
        _wheelTimer = [NSTimer scheduledTimerWithTimeInterval:_timeSpace
                                                       target:self
                                                     selector:@selector(changePage)
                                                     userInfo:nil
                                                      repeats:YES];
    }
    return _wheelTimer;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 15,
                                                                       self.bounds.size.width,
                                                                       10)];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

- (NSMutableArray *)operationArr
{
    if (!_operationArr) {
        _operationArr = [@[] mutableCopy];
    }
    return _operationArr;
}

@end


@interface IXWheelCell ()

@property (nonatomic, strong) UIImageView   * imgV;

@end

@implementation IXWheelCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _imgV = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV.clipsToBounds = YES;
        [self.contentView addSubview:_imgV];
    }
    return self;
}

- (void)setImgPath:(NSString *)imgPath
{
    _imgPath = imgPath;
    
    if ([imgPath containsString:@"http"]) {
        [_imgV setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:nil];
//        NSURLRequest * req  = [NSURLRequest requestWithURL:[NSURL URLWithString:imgPath]];
//        [_imgV setImageWithURLRequest:req placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
//            NSLog(@"-- ");
//        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
//            NSLog(@" -- ");
//        }];
    } else {
        _imgV.image = [UIImage imageNamed:imgPath];
    }
}

@end

//
//  YLSearchView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/17.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSearchView.h"

@interface YLSearchView ()

@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, strong) UIView *searchHistoryView;
@property (nonatomic, strong) UIView *hotSearchView;

@end

@implementation YLSearchView
- (instancetype)initWithFrame:(CGRect)frame historyArray:(NSMutableArray *)historyArray hotArray:(NSMutableArray *)hotArray {
    
    if (self = [super initWithFrame:frame]) {
        self.historyArray = historyArray;
        self.hotArray = hotArray;
        [self addSubview:self.searchHistoryView];
        [self addSubview:self.hotSearchView];
    }
    return self;
}

- (UIView *)hotSearchView
{
    if (!_hotSearchView) {
        self.hotSearchView = [self setViewWithOriginY:CGRectGetHeight(_searchHistoryView.frame) title:@"热门搜索" textArr:self.hotArray];
    }
    return _hotSearchView;
}


- (UIView *)searchHistoryView
{
    if (!_searchHistoryView) {
        if (_historyArray.count > 0) {
            self.searchHistoryView = [self setViewWithOriginY:0 title:@"最近搜索" textArr:self.historyArray];
        } else {
            self.searchHistoryView = [self setNoHistoryView];
        }
    }
    return _searchHistoryView;
}


- (UIView *)setViewWithOriginY:(CGFloat)originY title:(NSString *)title textArr:(NSMutableArray *)textArr {
    
    UIView *view = [[UIView alloc] init];
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, YLScreenWidth - 30 - 45, 30)];
    titleL.text = title;// 标题
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleL];
    
    if ([title isEqualToString:@"最近搜索"]) {// 删除按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(YLScreenWidth - 45, 10, 28, 30);
        [btn addTarget:self action:@selector(clearSearchHistory) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
    CGFloat y = 10 +40;
    CGFloat leftWidth = 15;
    for (int i = 0; i < textArr.count; i++) {
        NSString *text = textArr[i];
        CGFloat width = [text getSizeWithFont:[UIFont systemFontOfSize:12]].width + 30;
        if (leftWidth + width + 15 > YLScreenWidth) {
            if (y >= 130 && [title isEqualToString:@"最近搜索"]) {
                [self removeTestDataWithTextArr:textArr index:i];
                break;
            }
            y += 40;
            leftWidth = 15;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftWidth, y, width, 30)];
        label.userInteractionEnabled = YES;
        label.font = [UIFont systemFontOfSize:12];
        label.text = text;
        label.layer.borderWidth = 0.5;
        label.layer.cornerRadius = 5;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = YLColor(111, 111, 111);
        label.layer.borderColor = YLColor(227, 227, 227).CGColor;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDidCLick:)]];
        [view addSubview:label];
        leftWidth += width + 10;
    }
    view.frame = CGRectMake(0, originY, YLScreenWidth, y + 40);
    return view;
}

- (UIView *)setNoHistoryView {
    UIView *historyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 80)];
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, YLScreenWidth - 30, 30)];
    titleL.text = @"最近搜索";
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentLeft;
    
    UILabel *notextL = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleL.frame) + 10, 100, 20)];
    notextL.text = @"无搜索历史";
    notextL.font = [UIFont systemFontOfSize:12];
    notextL.textColor = [UIColor blackColor];
    notextL.textAlignment = NSTextAlignmentLeft;
    
    [historyView addSubview:titleL];
    [historyView addSubview:notextL];
    
    return historyView;
}

- (void)tapDidCLick:(UITapGestureRecognizer *)tap {
    
    UILabel *label = (UILabel *)tap.view;
    if (self.tapClick) {
        self.tapClick(label.text);
    }
}

- (void)clearSearchHistory {
    [self.searchHistoryView removeFromSuperview];
    self.searchHistoryView = [self setNoHistoryView];
    [self.historyArray removeAllObjects];
    [NSKeyedArchiver archiveRootObject:self.historyArray toFile:YLSearchHistoryPath];
    [self addSubview:self.searchHistoryView];
    CGRect frame = self.hotSearchView.frame;
    frame.origin.y = CGRectGetHeight(self.searchHistoryView.frame);
    self.hotSearchView.frame = frame;
}

- (void)removeTestDataWithTextArr:(NSMutableArray *)textArr index:(NSInteger)index {
    
    NSRange range = {index, textArr.count - index - 1};
    [textArr removeObjectsInRange:range];
    [NSKeyedArchiver archiveRootObject:textArr toFile:YLSearchHistoryPath];
}

- (void)setHotArray:(NSMutableArray *)hotArray {
    _hotArray = hotArray;
}

@end

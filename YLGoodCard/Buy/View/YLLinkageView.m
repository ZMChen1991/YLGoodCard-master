//
//  YLLinkageView.m
//  仿美团菜单栏
//
//  Created by lm on 2017/5/26.
//  Copyright © 2017年 CocaCola. All rights reserved.
//

#import "YLLinkageView.h"
#import "YLCustomPrice.h"
#import "YLSelectView.h"

#define SCREENWIDTH self.frame.size.width
#define LEFTWIDTH   (SCREENWIDTH / 3)
#define RIGHTWIDTH  (SCREENWIDTH - LEFTWIDTH)
#define HEIGHT       self.frame.size.height
#define btnH 35



@interface YLLinkageView ()

@property (nonatomic, strong) NSArray *dataArray;// 数据
@property (nonatomic, assign) BOOL selectState;// 默认不选中
@property (nonatomic, strong) UIView *background;// 蒙版
@property (nonatomic, strong) YLCustomPrice *customPrice;// 价格页面
@property (nonatomic, strong) UITableView *leftTableView;// 排序列表
@property (nonatomic, strong) YLSelectView *selectView;// 筛选页面

@end

static NSString * const leftIdentifier = @"LeftCellIdentifier";

@implementation YLLinkageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = @[@"最新上架", @"价格最低", @"价格最高", @"车龄最短", @"里程最少"];
        [self setUI];
    }
    return self;
}

- (void)setUI {

    NSArray *btns = @[@"排序", @"品牌", @"价格", @"筛选"];
    float btnW = YLScreenWidth / btns.count; // 屏幕宽/按钮数
    for (int i = 0; i < btns.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnW * i, 0, btnW, btnH);
        btn.tag = 100 + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@", btns[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        if (i > 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(btnW * i, 0, 1, btnH)]; // 按钮宽、按钮高
            line.backgroundColor = YLColor(237.f, 237.f, 237.f);
            [self addSubview:line];
        }
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, btnH, YLScreenWidth, 1)]; // 屏幕宽、按钮高
        line.backgroundColor = YLColor(237.0, 237.0, 237.0);
        [self addSubview:line];
    }
}

// 选中状态时，如果点击的是排序按钮，则显示列表，否则隐藏
- (void)selectBtn:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushCoverView:)]) {
        [self.delegate pushCoverView:sender];
    }
}


@end

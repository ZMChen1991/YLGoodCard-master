//
//  YLBargainHistoryDetailController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBargainHistoryDetailController.h"
#import "YLBargainHistoryDetailCell.h"
#import "YLBargainHistoryDetailHeader.h"
#import "YLBargainPriceView.h"


@interface YLBargainHistoryDetailController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dickers;// 砍价者数量

@property (nonatomic, strong) UIView *cover;// 蒙版

@property (nonatomic, strong) YLBargainHistoryDetailHeader *header;

@property (nonatomic, strong) YLBargainPriceView *bargainPriceView;


@end

@implementation YLBargainHistoryDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"砍价记录详情";
    
    [self creatTableView];
}

- (void)creatTableView {
    
    YLBargainHistoryDetailHeader *header = [[YLBargainHistoryDetailHeader alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, 110)];
    header.model = self.model;
    [self.view addSubview:header];
    self.header = header;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(header.frame), YLScreenWidth, YLScreenHeight - 110)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self.cover addSubview:self.bargainPriceView];
    [self.view addSubview:self.cover];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 23;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBargainHistoryDetailCell *cell = [YLBargainHistoryDetailCell cellWithTableView:tableView];
    cell.dickerBlock = ^{ // 还价
        self.cover.hidden = NO;
    };
    cell.accepBlock = ^{ // 接受
        
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UIView *)cover {
    if (!_cover) {
        _cover = [[UIView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, YLScreenHeight - 64)];
        _cover.hidden = YES;
        _cover.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5];
    }
    return _cover;
}

- (YLBargainPriceView *)bargainPriceView {
    if (!_bargainPriceView) {
        _bargainPriceView = [[YLBargainPriceView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 213 - 64, YLScreenWidth, 213)];
        __weak typeof(self) weakSelf = self;
        _bargainPriceView.bargainPriceBlock = ^(NSString * _Nonnull bargainPrice) {
            NSLog(@"bargainPrice:%@", bargainPrice);
            weakSelf.cover.hidden = YES;
        };
    }
    return _bargainPriceView;
}

@end

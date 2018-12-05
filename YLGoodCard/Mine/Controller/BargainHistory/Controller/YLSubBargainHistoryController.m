//
//  YLSubBargainHistoryController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSubBargainHistoryController.h"
#import "YLBargainHistoryCellFrame.h"
#import "YLBargainHistoryModel.h"
#import "YLBargainHistoryCell.h"
#import "YLBargainHistoryDetailController.h"


@interface YLSubBargainHistoryController ()

@end

@implementation YLSubBargainHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBargainHistoryCell *cell = [YLBargainHistoryCell cellWithTableView:tableView];
    YLBargainHistoryCellFrame *cellFrame = [[YLBargainHistoryCellFrame alloc] init];
    YLBargainHistoryModel *model = [[YLBargainHistoryModel alloc] init];
    cellFrame.model = model;
    cell.cellFrame = cellFrame;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLBargainHistoryCellFrame *cellFrame = [[YLBargainHistoryCellFrame alloc] init];
    YLBargainHistoryModel *model = [[YLBargainHistoryModel alloc] init];
    cellFrame.model = model;
    return cellFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBargainHistoryDetailController *detail = [[YLBargainHistoryDetailController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

@end

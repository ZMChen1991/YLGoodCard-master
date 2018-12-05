//
//  YLDepreciateController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDepreciateController.h"
#import "YLDepreciateCellFrame.h"
#import "YLDepreciateModel.h"
#import "YLDepreciateCell.h"
#import "YLDetailController.h"

@interface YLDepreciateController ()

@end

@implementation YLDepreciateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"降价提醒";
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLDepreciateCell *cell = [YLDepreciateCell cellWithTableView:tableView];
    YLDepreciateCellFrame *cellFrame = [[YLDepreciateCellFrame alloc] init];
    YLDepreciateModel *model = [[YLDepreciateModel alloc] init];
    cellFrame.model = model;
    cell.cellFrame = cellFrame;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLDepreciateCellFrame *cellFrame = [[YLDepreciateCellFrame alloc] init];
    YLDepreciateModel *model = [[YLDepreciateModel alloc] init];
    cellFrame.model = model;
    return cellFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"查看当前降价情况跳转详情页");
#warning 这里传当前车辆的模型数据,不然跳转详情页会崩溃
//    YLDetailController *detail = [[YLDetailController alloc] init];
//    detail.model = nil;
//    [self.navigationController pushViewController:detail animated:YES];
}

@end

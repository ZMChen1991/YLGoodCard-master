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
#import "YLRequest.h"
#import "YLBargainHistoryModel.h"
#import "YLBargainHistoryCellFrame.h"



@interface YLSubBargainHistoryController ()

@property (nonatomic, strong) NSMutableArray *bargainHistorys;

@end

@implementation YLSubBargainHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadData {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/bargain";
    [YLRequest GET:urlString parameters:self.param success:^(id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSLog(@"请求成功%@", responseObject[@"data"]);
            NSArray *models = [YLBargainHistoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (YLBargainHistoryModel *model in models) {
                YLBargainHistoryCellFrame *cellFrame = [[YLBargainHistoryCellFrame alloc] init];
                cellFrame.model = model;
                [self.bargainHistorys addObject:cellFrame];
            }
            [self.tableView reloadData];
        } else {
            NSLog(@"请求失败");
        }
        
    } failed:nil];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bargainHistorys.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBargainHistoryCell *cell = [YLBargainHistoryCell cellWithTableView:tableView];
    YLBargainHistoryCellFrame *cellFrame = self.bargainHistorys[indexPath.row];
    cell.cellFrame = cellFrame;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBargainHistoryCellFrame *cellFrame = self.bargainHistorys[indexPath.row];
    return cellFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLBargainHistoryCellFrame *cellFrame = self.bargainHistorys[indexPath.row];
    YLBargainHistoryModel *model = cellFrame.model;
    YLBargainHistoryDetailController *detail = [[YLBargainHistoryDetailController alloc] init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)setParam:(NSMutableDictionary *)param {
    _param = param;
    
    [self loadData];
}

- (NSMutableArray *)bargainHistorys {
    if (!_bargainHistorys) {
        _bargainHistorys = [NSMutableArray array];
    }
    return _bargainHistorys;
}
@end

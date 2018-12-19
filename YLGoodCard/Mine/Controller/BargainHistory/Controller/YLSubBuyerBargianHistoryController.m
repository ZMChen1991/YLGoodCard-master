//
//  YLSubBuyerBargianHistoryController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSubBuyerBargianHistoryController.h"
#import "YLBargainHistoryCellFrame.h"
#import "YLBargainHistoryModel.h"
//#import "YLBargainHistoryCell.h"
#import "YLBargainHistoryDetailController.h"
#import "YLRequest.h"
#import "YLBargainHistoryModel.h"
#import "YLBargainHistoryCellFrame.h"
#import "YLAccount.h"
#import "YLAccountTool.h"
#import "YLSubBuyerBargainHistoryCell.h"

@interface YLSubBuyerBargianHistoryController ()

@property (nonatomic, strong) NSMutableArray *buyerBargainHistorys;

@end

@implementation YLSubBuyerBargianHistoryController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
        [self.tableView.mj_header endRefreshing];
    }];
    
    [self loadData];
}

- (void)loadData {
    
    [self.buyerBargainHistorys removeAllObjects];
    YLAccount *account = [YLAccountTool account];
    NSString *urlString = @"http://ucarjava.bceapp.com/bargain?method=buyer";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:account.telephone forKey:@"telephone"];
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
         NSLog(@"YLSubBuyerBargianHistoryController-urlString:%@-param:%@ \nresponseObject:%@",urlString, param, responseObject);
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSLog(@"请求成功%@", responseObject[@"data"]);
            NSArray *models = [YLBargainHistoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (YLBargainHistoryModel *model in models) {
                YLBargainHistoryCellFrame *cellFrame = [[YLBargainHistoryCellFrame alloc] init];
                cellFrame.model = model;
                [self.buyerBargainHistorys addObject:cellFrame];
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
    return self.buyerBargainHistorys.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLSubBuyerBargainHistoryCell *cell = [YLSubBuyerBargainHistoryCell cellWithTableView:tableView];
    YLBargainHistoryCellFrame *cellFrame = self.buyerBargainHistorys[indexPath.row];
    cell.cellFrame = cellFrame;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBargainHistoryCellFrame *cellFrame = self.buyerBargainHistorys[indexPath.row];
    return cellFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLBargainHistoryCellFrame *cellFrame = self.buyerBargainHistorys[indexPath.row];
    YLBargainHistoryModel *model = cellFrame.model;
    YLBargainHistoryDetailController *detail = [[YLBargainHistoryDetailController alloc] init];
    __weak typeof(self) weakSelf = self;
    detail.bargainDetailBlock = ^{ // 进入砍价详情刷新数据
        [weakSelf loadData];
    };
    detail.model = model;
    detail.isBuyer = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (NSMutableArray *)buyerBargainHistorys {
    if (!_buyerBargainHistorys) {
        _buyerBargainHistorys = [NSMutableArray array];
    }
    return _buyerBargainHistorys;
}
@end

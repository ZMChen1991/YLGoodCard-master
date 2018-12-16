//
//  YLSubAllBuyOrderController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSubAllBuyOrderController.h"
#import "YLBuyOrderCell.h"
#import "YLBuyOrderCellFrame.h"
#import "YLBuyOrderModel.h"
#import "YLBuyOrderDetailController.h"
#import "YLRequest.h"
#import "YLAccountTool.h"
#import "YLAccount.h"
#import "YLBuyOrderModel.h"
#import "YLBuyOrderCellFrame.h"

@interface YLSubAllBuyOrderController ()
@property (nonatomic, strong) NSMutableArray *buyOrders;
@end

@implementation YLSubAllBuyOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self loadData];
        [self.tableView.mj_header endRefreshing];
    }];
    [self loadData];
}

- (void)loadData {
    
    [self.buyOrders removeAllObjects];
    YLAccount *account = [YLAccountTool account];
    NSString *urlString = @"http://ucarjava.bceapp.com/buy?method=my";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:account.telephone forKey:@"telephone"];
    [param setValue:@"" forKey:@"status"];
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"param :%@ respronseObject:%@",param, responseObject);
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSArray *buyOrderModels = [YLBuyOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (YLBuyOrderModel *model in buyOrderModels) {
                YLBuyOrderCellFrame *cellFrame = [[YLBuyOrderCellFrame alloc] init];
                cellFrame.model = model;
                [self.buyOrders addObject:cellFrame];
            }
            [self.tableView reloadData];
        }
    } failed:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.buyOrders.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBuyOrderCell *cell = [YLBuyOrderCell cellWithTableView:tableView];
    YLBuyOrderCellFrame *cellFrame = self.buyOrders[indexPath.row];
    cell.buyOrderCellFrame = cellFrame;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBuyOrderCellFrame *cellFrame = self.buyOrders[indexPath.row];
    return cellFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBuyOrderCellFrame *cellFrame = self.buyOrders[indexPath.row];
    YLBuyOrderModel *model = cellFrame.model;
    YLBuyOrderDetailController *buyOrderDetail = [[YLBuyOrderDetailController alloc] init];
    buyOrderDetail.model = model;
    [self.navigationController pushViewController:buyOrderDetail animated:YES];
}

- (NSMutableArray *)buyOrders {
    if (!_buyOrders) {
        _buyOrders = [NSMutableArray array];
    }
    return _buyOrders;
}

//- (void)setParam:(NSMutableDictionary *)param {
//    _param = param;
//    [self loadData];
//}
@end

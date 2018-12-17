//
//  YLSubBuyOrderController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSubBuyOrderController.h"
#import "YLBuyOrderCell.h"
#import "YLBuyOrderCellFrame.h"
#import "YLBuyOrderModel.h"
#import "YLBuyOrderDetailController.h"
#import "YLRequest.h"
#import "YLAccountTool.h"
#import "YLAccount.h"
#import "YLBuyOrderModel.h"
#import "YLBuyOrderCellFrame.h"

@interface YLSubBuyOrderController ()

@property (nonatomic, strong) NSMutableArray *buyOrders;

@end

@implementation YLSubBuyOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)loadData {
    
    NSLog(@"self.param:%@", self.param);
    NSString *urlString = @"http://ucarjava.bceapp.com/buy?method=my";
    [YLRequest GET:urlString parameters:self.param success:^(id  _Nonnull responseObject) {
        
        NSLog(@"%@", responseObject);
        
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (void)setParam:(NSMutableDictionary *)param {
    _param = param;
    [self loadData];
}

@end

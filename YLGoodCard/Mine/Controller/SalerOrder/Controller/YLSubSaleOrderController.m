//
//  YLSubSaleOrderController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSubSaleOrderController.h"
#import "YLSaleOrderCell.h"
#import "YLSaleOrderCellFrame.h"
#import "YLSaleOrderModel.h"
#import "YLAccount.h"
#import "YLAccountTool.h"
#import "YLRequest.h"
#import "YLSaleDetailController.h"

@interface YLSubSaleOrderController ()

@property (nonatomic, strong) NSMutableArray *saleOrders;

@end

@implementation YLSubSaleOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadData];
}

- (void)loadData {
    
//    YLAccount *account = [YLAccountTool account];
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:self.status forKey:@"status"];
//    [param setValue:account.telephone forKey:@"telephone"];
    NSString *urlString = @"http://ucarjava.bceapp.com/sell?method=my";
    [YLRequest GET:urlString parameters:self.param success:^(id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        NSArray *modelArray = [YLSaleOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (YLSaleOrderModel *model in modelArray) {
            YLSaleOrderCellFrame *cellFrame = [[YLSaleOrderCellFrame alloc] init];
            cellFrame.model = model;
            [self.saleOrders addObject:cellFrame];
        }
        [self.tableView reloadData];
    } failed:nil];
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.saleOrders.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLSaleOrderCell *cell = [YLSaleOrderCell cellWithTableView:tableView];
    YLSaleOrderCellFrame *cellFrame = self.saleOrders[indexPath.row];
    cell.saleOrderCellFrame = cellFrame;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLSaleOrderCellFrame *cellFrame = self.saleOrders[indexPath.row];
    return cellFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLSaleDetailController *saleDetail = [[YLSaleDetailController alloc] init];
    [self.navigationController pushViewController:saleDetail animated:YES];
}

- (NSMutableArray *)saleOrders {
    if (!_saleOrders) {
        _saleOrders = [NSMutableArray array];
    }
    return _saleOrders;
}

- (void)setParam:(NSMutableDictionary *)param {
    _param = param;
}

@end

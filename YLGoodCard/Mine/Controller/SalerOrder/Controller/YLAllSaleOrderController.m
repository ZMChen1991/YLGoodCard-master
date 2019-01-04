//
//  YLAllSaleOrderController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLAllSaleOrderController.h"
#import "YLSaleOrderCell.h"
#import "YLSaleOrderCellFrame.h"
#import "YLSaleOrderModel.h"
#import "YLAccount.h"
#import "YLAccountTool.h"
#import "YLRequest.h"
#import "YLSaleDetailController.h"

#define YLAllSaleOrderPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"AllSaleOrder.txt"]

@interface YLAllSaleOrderController ()

@property (nonatomic, strong) NSMutableArray *saleOrders;

@end

@implementation YLAllSaleOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self loadData];
        [self.tableView.mj_header endRefreshing];
    }];
    [self getLocalData];
    [self loadData];
}

- (void)loadData {
    
    [self.saleOrders removeAllObjects];
    YLAccount *account = [YLAccountTool account];
    NSString *urlString = @"http://ucarjava.bceapp.com/sell?method=my";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:account.telephone forKey:@"telephone"];
    [param setValue:@"" forKey:@"status"];
    __weak typeof(self) weakSelf = self;
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [weakSelf keyedArchiverObject:responseObject toFile:YLAllSaleOrderPath];
            [weakSelf getLocalData];
        }
    } failed:nil];
    
}

- (void)getLocalData {
    
    [self.saleOrders removeAllObjects];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:YLAllSaleOrderPath];
    NSArray *modelArray = [YLSaleOrderModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
    for (YLSaleOrderModel *model in modelArray) {
        YLSaleOrderCellFrame *cellFrame = [[YLSaleOrderCellFrame alloc] init];
        cellFrame.model = model;
        [self.saleOrders addObject:cellFrame];
    }
    [self.tableView reloadData];
}

- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"数据保存成功");
    } else {
        NSLog(@"保存失败");
    }
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
    
    YLSaleOrderCellFrame *cellFrame = self.saleOrders[indexPath.row];
    YLSaleOrderModel *model = cellFrame.model;
    YLSaleDetailController *saleDetail = [[YLSaleDetailController alloc] init];
    saleDetail.model = model;
    __weak typeof(self) weakSelf = self;
    saleDetail.saleDetailBlock = ^{
        [weakSelf loadData];
    };
    [self.navigationController pushViewController:saleDetail animated:YES];
}

- (NSMutableArray *)saleOrders {
    if (!_saleOrders) {
        _saleOrders = [NSMutableArray array];
    }
    return _saleOrders;
}

//- (void)setParam:(NSMutableDictionary *)param {
//    _param = param;
////    NSLog(@"param:%@", param);
//    [self loadData];
//}
@end

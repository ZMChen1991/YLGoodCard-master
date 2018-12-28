//
//  YLSubSellerBargainHistoryController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSubSellerBargainHistoryController.h"
#import "YLBargainHistoryCellFrame.h"
#import "YLBargainHistoryModel.h"
//#import "YLBargainHistoryCell.h"
#import "YLBargainHistoryDetailController.h"
#import "YLRequest.h"
#import "YLBargainHistoryModel.h"
#import "YLBargainHistoryCellFrame.h"
#import "YLAccount.h"
#import "YLAccountTool.h"
#import "YLSubSellerBargainHistoryCell.h"

#define YLSellerBargainHistoryPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"SellerBargainHistory.txt"]

@interface YLSubSellerBargainHistoryController ()

@property (nonatomic, strong) NSMutableArray *sellerBargainHistorys;

@end

@implementation YLSubSellerBargainHistoryController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
        [self.tableView.mj_header endRefreshing];
    }];
    [self getLocalData];
    [self loadData];
}

- (void)loadData {
    
    [self.sellerBargainHistorys removeAllObjects];
    YLAccount *account = [YLAccountTool account];
    NSString *urlString = @"http://ucarjava.bceapp.com/bargain?method=seller";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:account.telephone forKey:@"telephone"];
    __weak typeof(self) weakSelf = self;
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"YLSubSellerBargainHistoryController-urlString:%@-param:%@ \nresponseObject:%@",urlString, param, responseObject);
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [weakSelf keyedArchiverObject:responseObject toFile:YLSellerBargainHistoryPath];
            [weakSelf getLocalData];
            
//            NSLog(@"请求成功%@", responseObject[@"data"]);
//            NSArray *models = [YLBargainHistoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//            for (YLBargainHistoryModel *model in models) {
//                YLBargainHistoryCellFrame *cellFrame = [[YLBargainHistoryCellFrame alloc] init];
//                cellFrame.model = model;
//                [self.sellerBargainHistorys addObject:cellFrame];
//            }
//            [self.tableView reloadData];
        } else {
            NSLog(@"请求失败");
        }
        
    } failed:nil];
    
}

- (void)getLocalData {
    
    [self.sellerBargainHistorys removeAllObjects];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:YLSellerBargainHistoryPath];
    NSArray *models = [YLBargainHistoryModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
    for (YLBargainHistoryModel *model in models) {
        YLBargainHistoryCellFrame *cellFrame = [[YLBargainHistoryCellFrame alloc] init];
        cellFrame.model = model;
        [self.sellerBargainHistorys addObject:cellFrame];
    }
    [self.tableView reloadData];
}

- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"即将看车下架数据保存成功");
    } else {
        NSLog(@"保存失败");
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sellerBargainHistorys.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLSubSellerBargainHistoryCell *cell = [YLSubSellerBargainHistoryCell cellWithTableView:tableView];
    YLBargainHistoryCellFrame *cellFrame = self.sellerBargainHistorys[indexPath.row];
    cell.cellFrame = cellFrame;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBargainHistoryCellFrame *cellFrame = self.sellerBargainHistorys[indexPath.row];
    return cellFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBargainHistoryCellFrame *cellFrame = self.sellerBargainHistorys[indexPath.row];
    YLBargainHistoryModel *model = cellFrame.model;
    if([model.detail.status isEqualToString:@"3"]) {// 车辆在售中
        YLBargainHistoryDetailController *detail = [[YLBargainHistoryDetailController alloc] init];
        __weak typeof(self) weakSelf = self;
        detail.bargainDetailBlock = ^{ // 进入砍价详情刷新数据
            [weakSelf loadData];
        };
        detail.isBuyer = NO;
        detail.model = model;
        [self.navigationController pushViewController:detail animated:YES];
    } else if ([model.detail.status isEqualToString:@"4"]) {
        NSLog(@"车辆已下架");
        [self showMessage:@"车辆已下架"];
    } else if ([model.detail.status isEqualToString:@"0"]) {
        NSLog(@"车辆已取消");
        [self showMessage:@"车辆已取消"];
    } else {
        NSLog(@"车辆已出售");
        [self showMessage:@"车辆已出售"];
    }
    
    
}

// 提示弹窗
- (void)showMessage:(NSString *)message {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;// 获取最上层窗口
    
    UILabel *messageLabel = [[UILabel alloc] init];
    CGSize messageSize = CGSizeMake([message getSizeWithFont:[UIFont systemFontOfSize:12]].width + 50, 50);
    messageLabel.frame = CGRectMake((YLScreenWidth - messageSize.width) / 2, YLScreenHeight/2, messageSize.width, messageSize.height);
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = YLColor(233.f, 233.f, 233.f);
    messageLabel.layer.cornerRadius = 5.0f;
    messageLabel.layer.masksToBounds = YES;
    [window addSubview:messageLabel];
    
    [UIView animateWithDuration:2 animations:^{
        messageLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [messageLabel removeFromSuperview];
    }];
}

- (NSMutableArray *)sellerBargainHistorys {
    if (!_sellerBargainHistorys) {
        _sellerBargainHistorys = [NSMutableArray array];
    }
    return _sellerBargainHistorys;
}
@end

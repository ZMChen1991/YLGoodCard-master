//
//  YLCollectedCarController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/24.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCollectedCarController.h"
#import "YLCollectionModel.h"
#import "YLCollectCellFrame.h"
#import "YLCollectCell.h"
#import "YLDetailController.h"
#import "YLTableViewModel.h"
#import "YLAccountTool.h"
#import "YLAccount.h"
#import "YLRequest.h"

#define YLCollectedCarPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collectedCar.txt"]

@interface YLCollectedCarController ()

@property (nonatomic, strong) NSMutableArray *collectArray;

@end

@implementation YLCollectedCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshLookCarData)];
    
//    [self getLocalData];
    [self loadData];
}

- (void)refreshLookCarData {
    [self loadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)loadData {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/collection?method=my";
    __weak typeof(self) weakSelf = self;
    YLAccount *account = [YLAccountTool account];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:account.telephone forKey:@"telephone"];
    [param setObject:@"0" forKey:@"status"];// 在售
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [weakSelf keyedArchiverObject:responseObject toFile:YLCollectedCarPath];
            [weakSelf getLocalData];
        }
    } failed:nil];
    
}

- (void)getLocalData {
    
    [self.collectArray removeAllObjects];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:YLCollectedCarPath];
    NSArray *array = [YLCollectionModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
    for (YLCollectionModel *model in array) {
        YLCollectCellFrame *cellFrame = [[YLCollectCellFrame alloc] init];
        cellFrame.collectionModel = model;
        [self.collectArray addObject:cellFrame];
    }
    [self.tableView reloadData];
}

- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"下架车辆收藏数据保存成功");
    } else {
        NSLog(@"保存失败");
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.collectArray.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLCollectCell *cell = [YLCollectCell cellWithTableView:tableView];
    YLCollectCellFrame *cellFrame = self.collectArray[indexPath.row];
    cell.collectCellFrame = cellFrame;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLCollectCellFrame *cellFrame = self.collectArray[indexPath.row];
    return cellFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YLCollectCellFrame *cellFrame = self.collectArray[indexPath.row];
    YLTableViewModel *model = [YLTableViewModel mj_objectWithKeyValues:cellFrame.collectionModel.detail];
    YLDetailController *detail = [[YLDetailController alloc] init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}


- (NSMutableArray *)collectArray {
    if (!_collectArray) {
        _collectArray = [NSMutableArray array];
    }
    return _collectArray;
}
@end

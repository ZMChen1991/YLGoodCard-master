//
//  YLCollectingCarController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/24.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCollectingCarController.h"
#import "YLCollectionModel.h"
#import "YLCollectCellFrame.h"
#import "YLCollectCell.h"
#import "YLDetailController.h"
#import "YLTableViewModel.h"
#import "YLAccountTool.h"
#import "YLAccount.h"
#import "YLRequest.h"
#import "YLCollectionModel.h"
#import "YLCollectCellFrame.h"
#import "YLNoneView.h"

#define YLCollectingCarPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collectingCar.txt"]

@interface YLCollectingCarController ()

@property (nonatomic, strong) NSMutableArray *collectArray;
@property (nonatomic, strong) YLNoneView *noneView;

@end

@implementation YLCollectingCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshLookCarData)];
    
    [self getLocalData];
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
    [param setObject:@"3" forKey:@"status"];// 在售
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [weakSelf keyedArchiverObject:responseObject toFile:YLCollectingCarPath];
            [weakSelf getLocalData];
        }
    } failed:nil];
    
}

- (void)getLocalData {
    
    [self.collectArray removeAllObjects];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:YLCollectingCarPath];
    NSArray *array = [YLCollectionModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
    for (YLCollectionModel *model in array) {
        YLCollectCellFrame *cellFrame = [[YLCollectCellFrame alloc] init];
        cellFrame.collectionModel = model;
        [self.collectArray addObject:cellFrame];
    }
    if (self.collectArray.count == 0 || self.collectArray == nil) {
        self.noneView.hidden = NO;
    } else {
        self.noneView.hidden = YES;
    }
    [self.tableView reloadData];
}

- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"在售车辆收藏数据保存成功");
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

- (YLNoneView *)noneView {
    if (!_noneView) {
        _noneView = [[YLNoneView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
        _noneView.title = @"暂无相关订单";
        _noneView.hidden = YES;
        [_noneView hideBtn];
        [self.view addSubview:_noneView];
    }
    return _noneView;
}

@end

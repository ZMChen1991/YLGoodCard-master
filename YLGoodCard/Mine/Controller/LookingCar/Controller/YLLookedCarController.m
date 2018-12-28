//
//  YLLookedCarController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/24.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLLookedCarController.h"
#import "YLLookCarModel.h"
#import "YLSubCellModel.h"
#import "YLSubCell.h"
#import "YLRequest.h"
#import "YLLookCarDetailController.h"
#import "YLAccountTool.h"
#import "YLAccount.h"

#define YLLookedCarPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"LookedCar.txt"]

@interface YLLookedCarController ()

@property (nonatomic, strong) NSMutableArray *lookCars;

@end

@implementation YLLookedCarController

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
    
    NSString *urlString = @"http://ucarjava.bceapp.com/buy?method=book";
    __weak typeof(self) weakSelf = self;
    YLAccount *account = [YLAccountTool account];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:account.telephone forKey:@"telephone"];
    [param setObject:@"0" forKey:@"status"];// 下架
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [weakSelf keyedArchiverObject:responseObject toFile:YLLookedCarPath];
            [weakSelf getLocalData];
        }
    } failed:nil];
    
}

- (void)getLocalData {
    
    [self.lookCars removeAllObjects];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:YLLookedCarPath];
    NSArray *array = [YLLookCarModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
    for (YLLookCarModel *model in array) {
        YLSubCellModel *cellFrame = [[YLSubCellModel alloc] init];
        cellFrame.lookCarModel = model;
        [self.lookCars addObject:cellFrame];
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
    return self.lookCars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLSubCell *cell = [YLSubCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YLSubCellModel *model = self.lookCars[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLSubCellModel *model = self.lookCars[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"");
    
    YLSubCellModel *model = self.lookCars[indexPath.row];
    YLLookCarDetailController *detail = [[YLLookCarDetailController alloc] init];
    detail.model = model.lookCarModel;
    [self.navigationController pushViewController:detail animated:YES];
}

- (NSMutableArray *)lookCars {
    if (!_lookCars) {
        _lookCars = [NSMutableArray array];
    }
    return _lookCars;
}

//- (void)setParam:(NSMutableDictionary *)param {
//    _param = param;
//}
@end

//
//  YLDepreciateController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDepreciateController.h"
#import "YLDepreciateCellFrame.h"
#import "YLDepreciateModel.h"
#import "YLDepreciateCell.h"
#import "YLDetailController.h"
#import "YLRequest.h"
#import "YLAccountTool.h"
#import "YLAccount.h"
#import "YLDepreciateModel.h"
#import "YLDepreciateCellFrame.h"
#import "YLTableViewModel.h"

#define YLDepreciatePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Depreciate.txt"]

@interface YLDepreciateController ()

@property (nonatomic, strong) NSMutableArray *depreciates;

@end

@implementation YLDepreciateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.title = @"降价提醒";
    
    [self getLocalData];
    [self loadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLEVIEW" object:nil];
}

- (void)loadData {
    
    YLAccount *account = [YLAccountTool account];
    NSString *urlString = @"http://ucarjava.bceapp.com/reduce?method=my";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:account.telephone forKey:@"telephone"];
    __weak typeof(self) weakSelf = self;
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            NSLog(@"降价提醒请求成功");
            [weakSelf keyedArchiverObject:responseObject toFile:YLDepreciatePath];
            [weakSelf getLocalData];
            
//            NSArray *array = [YLDepreciateModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//            for (YLDepreciateModel *model in array) {
//                YLDepreciateCellFrame *cellFrame = [[YLDepreciateCellFrame alloc] init];
//                cellFrame.model = model;
//                [self.depreciates addObject:cellFrame];
//            }
//            [self.tableView reloadData];
        } else {
            NSLog(@"降价提醒请求失败");
        }
        
    } failed:nil];
}

- (void)getLocalData {
    
    [self.depreciates removeAllObjects];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:YLDepreciatePath];
    NSArray *array = [YLDepreciateModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
    for (YLDepreciateModel *model in array) {
        YLDepreciateCellFrame *cellFrame = [[YLDepreciateCellFrame alloc] init];
        cellFrame.model = model;
        [self.depreciates addObject:cellFrame];
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
    return self.depreciates.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLDepreciateCell *cell = [YLDepreciateCell cellWithTableView:tableView];
    YLDepreciateCellFrame *cellFrame = self.depreciates[indexPath.row];
    cell.cellFrame = cellFrame;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLDepreciateCellFrame *cellFrame = self.depreciates[indexPath.row];
    return cellFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"查看当前降价情况跳转详情页");
    YLDepreciateCellFrame *cellFrame = self.depreciates[indexPath.row];
    YLDepreciateDetailModel *detailModel = cellFrame.model.detail;
    YLTableViewModel *model = [YLTableViewModel mj_objectWithKeyValues:detailModel];
    YLDetailController *detail = [[YLDetailController alloc] init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}

- (NSMutableArray *)depreciates {
    if (!_depreciates) {
        _depreciates = [NSMutableArray array];
    }
    return _depreciates;
}

@end

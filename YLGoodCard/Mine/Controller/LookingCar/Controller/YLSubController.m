//
//  YLSubController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSubController.h"
#import "YLSuggestionController.h"
#import "YLMineTool.h"
#import "YLLookCarModel.h"
#import "YLSubCellModel.h"
#import "YLSubCell.h"
#import "YLLookCarDetailController.h"
#import "YLRequest.h"


@interface YLSubController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YLSubController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)loadData {
    
//    // 根据提供的参数提交请求获取数据
//    [YLMineTool lookforWithParam:self.param success:^(NSArray * _Nonnull result) {
//        NSLog(@"YLSubController:%@", result);
//        for (YLLookCarModel *model in result) {
//            YLSubCellModel *cellModel = [[YLSubCellModel alloc] init];
//            cellModel.lookCarModel = model;
//            [self.dataArray addObject:cellModel];
//            [self.tableView reloadData];
//        }
//    } failure:nil];
    
    NSString *urlString  = @"http://ucarjava.bceapp.com/buy?method=book";
    [YLRequest GET:urlString parameters:self.param success:^(id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSLog(@"请求成功:%@", responseObject[@"data"]);
            NSArray *array = [YLLookCarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (YLLookCarModel *model in array) {
                YLSubCellModel *cellFrame = [[YLSubCellModel alloc] init];
                cellFrame.lookCarModel = model;
                [self.dataArray addObject:cellFrame];
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
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    YLSubCell *cell = [YLSubCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YLSubCellModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLSubCellModel *model = self.dataArray[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLSubCellModel *model = self.dataArray[indexPath.row];
    YLLookCarDetailController *detail = [[YLLookCarDetailController alloc] init];
    detail.model = model.lookCarModel;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)setParam:(NSMutableDictionary *)param {
    _param = param;
    [self loadData];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end

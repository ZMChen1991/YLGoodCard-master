//
//  YLBrowseController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBrowseController.h"
#import "YLTableViewCell.h"
#import "YLTableViewModel.h"

// 浏览记录路径
#define YLBrowsingHistoryPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"browsingHistory.plist"]

@interface YLBrowseController ()

@property (nonatomic, strong) NSMutableArray *browsingHistory;

@end

@implementation YLBrowseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取本地浏览记录个数
    NSInteger count = self.browsingHistory.count;
    NSLog(@"count:%ld", count);
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.browsingHistory.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLTableViewCell *cell = [YLTableViewCell cellWithTableView:tableView];
    YLTableViewModel *model = self.browsingHistory[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (NSMutableArray *)browsingHistory {
    if (!_browsingHistory) {
        _browsingHistory = [NSKeyedUnarchiver unarchiveObjectWithFile:YLBrowsingHistoryPath];
        if (!_browsingHistory) {
            _browsingHistory = [NSMutableArray array];
        }
    }
    return _browsingHistory;
}

@end

//
//  YLConfigController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLConfigController.h"
#import "YLConfigHeaderView.h"
#import "YLRequest.h"

#define YLConfigPath(typeID) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:typeID]

@interface YLConfigController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSArray *groups;
@property (nonatomic, strong) NSArray *rows;


@end

@implementation YLConfigController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"车辆参数配置";
    
    YLConfigHeaderView *header = [[YLConfigHeaderView alloc] init];
    header.frame = CGRectMake(0, 0, YLScreenWidth, 106);
    header.model = self.model;
    [self.view addSubview:header];
    [self.view addSubview:self.tableView];
    
    [self getLocationData];
    [self loadData];
}

- (void)loadData {
    
    NSString *urlString = [NSString stringWithFormat:@"http://ucarjava.bceapp.com/detail?method=config&id=%@", self.model.typeId];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    __weak typeof(self) weakSelf = self;
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
//            NSLog(@"responseObject:%@", responseObject);
            [weakSelf keyedArchiverObject:responseObject toFile:YLConfigPath(weakSelf.model.typeId)];
            [weakSelf getLocationData];
        }
    } failed:nil];
}

- (void)getLocationData {
    
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:YLConfigPath(self.model.typeId)];
    self.data = dic[@"data"];
    self.groups = [self.data allKeys];
//    NSDictionary *dict = [responseObject[@"data"]];
//    self.data = dict;
//    NSArray *keys = [dict allKeys];
//    self.groups = keys;
//    NSLog(@"keys%@", keys);
    [self.tableView reloadData];
}

- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"详情数据保存成功");
    } else {
        NSLog(@"保存失败");
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data[self.groups[section]] count];
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"YLConfigController";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    NSLog(@"%ld-%ld", indexPath.section, indexPath.row);
    self.rows = self.data[self.groups[indexPath.section]];
    NSDictionary *dic = self.rows[indexPath.row];
    cell.textLabel.text = [dic valueForKey:@"key"];
    cell.detailTextLabel.text = [dic valueForKey:@"value"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.groups[section];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 106, YLScreenWidth, YLScreenHeight - 106 - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.bounces = NO;
    }
    return _tableView;
}

@end

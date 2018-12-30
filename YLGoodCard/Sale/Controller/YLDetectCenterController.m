//
//  YLDetectCenterController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/4.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetectCenterController.h"
#import "YLDetectCenterCell.h"
#import "YLRequest.h"

#define YLDetectCenterPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"DetectCenter.txt"]

@interface YLDetectCenterController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *detectCenters;

@end

@implementation YLDetectCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"检测中心";
    
    [self createTableView];
    [self getLocationData];
    [self loadData];
}

- (void)loadData {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/center?method=city";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.city forKey:@"city"];
    // 获取检测中心数据
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            NSLog(@"获取检测中心数据成功");
            [self keyedArchiverObject:responseObject toFile:YLDetectCenterPath];
            [self getLocationData];
//            self.detectCenters = [YLDetectCenterModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//            [self.tableView reloadData];
        }
    } failed:nil];
}

- (void)getLocationData {
    
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:YLDetectCenterPath];
    self.detectCenters = [YLDetectCenterModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
    [self.tableView reloadData];
}

- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"首页数据保存成功");
    } else {
        NSLog(@"保存失败");
    }
}

- (void)createTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detectCenters.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLDetectCenterCell *cell = [YLDetectCenterCell cellWithTableView:tableView];
    YLDetectCenterModel *model = self.detectCenters[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 97;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLDetectCenterModel *model = self.detectCenters[indexPath.row];
    if (self.detectCenterBlock) {
        self.detectCenterBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end

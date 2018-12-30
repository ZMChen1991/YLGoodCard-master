//
//  YLCarTypeController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/23.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCarTypeController.h"
//#import "YLBuyTool.h"
#import "YLRequest.h"
#import "YLCarTypeModel.h"

@interface YLCarTypeController ()

@property (nonatomic, strong) NSMutableArray *carTypes;// 车型数组

@end

@implementation YLCarTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择车型";
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self loadData];
}

- (void)loadData {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/vehicle?method=config";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = self.seriesModel.seriesId;
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        self.carTypes = [YLCarTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        YLCarTypeModel *model = [[YLCarTypeModel alloc] init];
        model.typeName = @"不限";
        model.typeId = @"0000";
        if (!self.carTypes.count) {
            [self.carTypes addObject:model];
        }
        [self.tableView reloadData];
    } failed:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carTypes.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"Cell";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    YLCarTypeModel *model = self.carTypes[indexPath.row];
    cell.textLabel.text = model.typeName;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLCarTypeModel *model = self.carTypes[indexPath.row];
    NSLog(@"%@ %@", model.typeName, model.typeId);
    if (self.carTypeBlock) {
        self.carTypeBlock(model.typeName, model.typeId);
    }
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] - 4)] animated:YES];
}

- (NSMutableArray *)carTypes {
    
    if (!_carTypes) {
        _carTypes = [NSMutableArray array];
    }
    return _carTypes;
}

@end

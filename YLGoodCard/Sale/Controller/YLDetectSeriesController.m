//
//  YLDetectSeriesController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/4.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetectSeriesController.h"
#import "YLCarTypeController.h"
#import "YLBuyTool.h"
#import "YLSeriesModel.h"

@interface YLDetectSeriesController ()

@property (nonatomic, strong) NSArray *series;

@end

@implementation YLDetectSeriesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择车系";
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = self.model.brandId;
    [YLBuyTool seriesWithParam:param success:^(NSArray<YLSeriesModel *> * _Nonnull result) {
        self.series = result;
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.series.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"YLSeriesController";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    YLSeriesModel *model = self.series[indexPath.row];
    cell.textLabel.text = model.series;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLSeriesModel *model = self.series[indexPath.row];
    self.cartype = [[YLCarTypeController alloc] init];
    self.cartype.seriesModel = model;
    __weak typeof(self)weakSelf = self;
    self.cartype.carTypeBlock = ^(NSString * _Nonnull carType, NSString * _Nonnull typeId) {
        if (weakSelf.seriesBlock) {
            weakSelf.seriesBlock(model.series, carType, typeId);
        }
    };
    [self.navigationController pushViewController:self.cartype animated:YES];
}


- (NSArray *)series {
    if (!_series) {
        _series = [NSArray array];
    }
    return _series;
}
@end

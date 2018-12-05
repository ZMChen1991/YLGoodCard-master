//
//  YLSeriesController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/22.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSeriesController.h"
//#import "YLBrandTool.h"
#import "YLBuyTool.h"
#import "YLSeriesModel.h"
#import "YLTabBarController.h"
#import "YLNavigationController.h"
#import "YLBuyController.h"


@interface YLSeriesController ()

@property (nonatomic, strong) NSArray *series;

@end

@implementation YLSeriesController

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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLSeriesModel *model = self.series[indexPath.row];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.model.brand forKey:@"brand"];
    [param setValue:model.series forKey:@"series"];
    // 获取tabBarVC里的导航控制器存放的子控制器，传值到子控制器，再切换视图
    YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    YLNavigationController *nav2 = tab.viewControllers[1];
    YLBuyController *buy = nav2.viewControllers.firstObject;
    buy.param = param;
    tab.selectedIndex = 1;
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (NSArray *)series {
    if (!_series) {
        _series = [NSArray array];
    }
    return _series;
}

@end

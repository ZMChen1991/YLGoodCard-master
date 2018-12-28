//
//  YLBrandController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBrandController.h"
#import "YLBuyTool.h"
#import "YLBrandModel.h"
#import "YLSeriesController.h"
#import "YLRequest.h"

#define YLBrandPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"brand.txt"]
#define YLGroupPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"group.txt"]

@interface YLBrandController ()

@property (nonatomic, strong) NSMutableArray *brands;// 汽车品牌
@property (nonatomic, strong) NSMutableArray *groups;// 组

@end

@implementation YLBrandController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择品牌";
    
    [self getLocationData];
    [self loadData];
}

- (void)loadData {
    
    // 思路：一组装字母，再以字母x筛选出品牌装进数组，然后用另一数组存该数组
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    __weak typeof(self) weakSelf = self;
    [YLBuyTool brandWithParam:param success:^(NSArray<YLBrandModel *> * _Nonnull result) {
        NSMutableArray *group = [NSMutableArray array];
        // 取出首字母
        for (YLBrandModel *model in result) {
            NSString *zimu = model.initialLetter;
            [group addObject:zimu];
        }
        NSSet *set = [NSSet setWithArray:group];
        NSMutableArray *groups = [NSMutableArray arrayWithArray:[set allObjects]];
        [weakSelf keyedArchiverObject:groups toFile:YLGroupPath];

        // 根据首字母取出汽车品牌存放在数组里
        NSMutableArray *brands = [NSMutableArray array];
        for (NSInteger i = 0; i < weakSelf.groups.count; i++) {
            NSString *str = weakSelf.groups[i];
            NSMutableArray *array = [NSMutableArray array];
            for (YLBrandModel *model in result) {
                if ([str isEqualToString:model.initialLetter]) {
                    [array addObject:model];
                }
            }
            // 将首字母的c汽车品牌数组存放在数组里
            [brands addObject:array];
        }
        [weakSelf keyedArchiverObject:brands toFile:YLBrandPath];
        [weakSelf getLocationData];
//        [self.tableView reloadData];
    } failure:^(NSError * error) {

    }];
}

- (void)getLocationData {
    
    self.groups = [NSKeyedUnarchiver unarchiveObjectWithFile:YLGroupPath];
    self.brands = [NSKeyedUnarchiver unarchiveObjectWithFile:YLBrandPath];
    [self.tableView reloadData];
}

- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"保存成功");
    } else {
        NSLog(@"保存失败");
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.brands.count == 0) {
        return 0;
    } else {
        return [self.brands[section] count];
    }
    
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"YLBrandController";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    YLBrandModel *model = self.brands[indexPath.section][indexPath.row];
    cell.textLabel.text = model.brand;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBrandModel *model = self.brands[indexPath.section][indexPath.row];
    YLSeriesController *series = [[YLSeriesController alloc] init];
    series.model = model;
    __weak typeof(self) weakSelf = self;
    series.buySeriesBlock = ^(NSString * _Nonnull series) {
        NSLog(@"series%@", series);
        if (weakSelf.buyBrandBlock) {
            weakSelf.buyBrandBlock(model.brand, series);
        }
    };
    [self.navigationController pushViewController:series animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.groups[section];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.groups;
}

- (NSMutableArray *)brands {
    
    if (!_brands) {
        _brands = [NSMutableArray array];
    }
    return _brands;
}

@end

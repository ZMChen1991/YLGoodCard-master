//
//  YLBrandView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/26.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBrandView.h"
#import "YLBrandModel.h"

@interface YLBrandView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YLBrandView

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableFooterView = [[UIView alloc] init];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"self.brands:%ld", [self.brands[section] count]);
    if (![_brands[section] count]) {
        return 0;
    } else {
        return [_brands[section] count];
    }
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"YLBrandView";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
//    NSLog(@"%@", self.brands[indexPath.section][indexPath.row]);
    YLBrandModel *model = self.brands[indexPath.section][indexPath.row];
    cell.textLabel.text = model.brand;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBrandModel *model = self.brands[indexPath.section][indexPath.row];
    
    // 获取点击的品牌，传出去
    if (self.BrandViewBlock) {
        self.BrandViewBlock(model);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _groups[section];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return _groups;
}

- (void)setGroups:(NSMutableArray *)groups {
    
    _groups = groups;
    [self.tableView reloadData];
}

- (void)setBrands:(NSMutableArray *)brands {
    
    _brands = brands;
    [self setupUI];
    [self.tableView reloadData];
}
@end

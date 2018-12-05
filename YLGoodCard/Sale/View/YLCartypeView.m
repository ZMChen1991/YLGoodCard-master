//
//  YLCartypeView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/26.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCartypeView.h"

@interface YLCartypeView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YLCartypeView

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carTypes.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"YLSeriesView";
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
    if (self.carTypeBlock) {
        self.carTypeBlock(model);
    }
}

- (void)setCarTypes:(NSMutableArray *)carTypes {
    
//    YLCarTypeModel *model = [[YLCarTypeModel alloc] init];
//    model.name = @"不限";
//    model.ID = @"0000";
//    if (![carTypes count]) {
//        [carTypes addObject:model];
//    } else {
//        [carTypes insertObject:model atIndex:0];
//    }
    _carTypes = carTypes;
    
    [self setupUI];
    [self.tableView reloadData];
}

@end

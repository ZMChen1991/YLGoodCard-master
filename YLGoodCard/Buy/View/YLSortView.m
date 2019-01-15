//
//  YLSortView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/10.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSortView.h"
#import "YLBuyConditionModel.h"

@interface YLSortView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end


@implementation YLSortView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
//        self.dataArray = @[@"最新上架", @"价格最低", @"价格最高", @"车龄最短", @"里程最少"];
        [self addSubview:self.tableView];
    }
    return self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.models.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"YLSortView";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    YLBuyConditionModel *model = self.models[indexPath.row];
    if (model.isSelect) {
        cell.textLabel.textColor = YLColor(8.f, 169.f, 255.f);
    } else {
        cell.textLabel.textColor = YLColor(51.f, 51.f, 51.f);
    }
    cell.textLabel.text = model.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    // 将选中的状态还原
    for (YLBuyConditionModel *model in self.models) {
        if (model.isSelect) {
            model.isSelect = !model.isSelect;
        }
    }
    // 修改选中行的状态
    YLBuyConditionModel *model = self.models[indexPath.row];
    model.isSelect = !model.isSelect;
    NSLog(@"点击了%@", model.title);
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATIONREFRESHPARAMVIEW" object:nil];
    if (self.sortViewBlock) {
        self.sortViewBlock(self.models);
    }
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor]; // 清除背景颜色
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;// 禁止弹跳
    }
    return _tableView;
}

- (void)setModels:(NSArray *)models {
    _models = [models copy];
    [self.tableView reloadData];
}


@end

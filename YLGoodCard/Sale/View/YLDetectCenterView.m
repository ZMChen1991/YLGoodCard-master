//
//  YLDetectCenterView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetectCenterView.h"
#import "YLDetectCenterCell.h"

@interface YLDetectCenterView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YLDetectCenterView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    NSInteger width = self.frame.size.width;
    NSInteger height = self.frame.size.height - 22;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 52)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, 20, width - 2 * YLLeftMargin, 22)];
//    title.backgroundColor = [UIColor redColor];
    title.font = [UIFont systemFontOfSize:16];
    title.text = @"检测中心";
    title.textColor = [UIColor blackColor];
    [view addSubview:title];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor greenColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    UILabel *foot = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, 10, width, 20)];
    foot.text = @"更多检测中心正在进驻...";
    foot.font = [UIFont systemFontOfSize:14];
    [footer addSubview:foot];
    self.tableView.tableFooterView = footer;
    self.tableView.tableHeaderView = view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.detectCenters.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"YLDetectCenterView";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    YLDetectCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[YLDetectCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    YLDetectCenterModel *model = self.detectCenters[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLDetectCenterModel *model = self.detectCenters[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(detectCenterClick:)]) {
        [self.delegate detectCenterClick:model];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 97;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

- (void)setDetectCenters:(NSArray *)detectCenters {
    
    _detectCenters = detectCenters;
    [self.tableView reloadData];
}


@end

//
//  YLSubscribeDetailController.m
//  YLGoodCard
//
//  Created by lm on 2019/1/17.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLSubscribeDetailController.h"
#import "YLSubscribeDetailModel.h"
#import "YLRequest.h"
#import "YLSubscribeCellFrame.h"
#import "YLSubscribeCell.h"
#import "YLDetailController.h"
#import "YLSubcribeParamView.h"

#define YLSubscribeDetailPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MySubscribeDetail.txt"]

@interface YLSubscribeDetailController ()

@property (nonatomic, strong) NSMutableArray<YLSubscribeCellFrame *> *detailModels;

@end

@implementation YLSubscribeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订阅详情";
    
    [self createTableViewHeader];
    [self getLocationData];
    [self loadData];
}

- (void)createTableViewHeader {
    
    CGFloat headerH = 50;
    CGFloat labelW = 70;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, headerH)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, 0, labelW, headerH)];
    label.text = @"当前条件:";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = YLColor(51.f, 51.f, 51.f);
    [view addSubview:label];
    
//    YLSubcribeParamView *paramView = [[YLSubcribeParamView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, headerH)];
    YLSubcribeParamView *paramView = [[YLSubcribeParamView alloc] initWithFrame:CGRectMake(labelW + YLLeftMargin, 0, YLScreenWidth - 2 * YLLeftMargin - labelW, headerH)];
    paramView.backgroundColor = [UIColor redColor];
    paramView.params = self.params;
    [view addSubview:paramView];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(paramView.frame), YLScreenWidth, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [view addSubview:line];
    
    self.tableView.tableHeaderView = view;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)loadData {
    
    [self.detailModels removeAllObjects];
    NSString *urlString = @"http://ucarjava.bceapp.com/subscribe?method=id";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:self.model.subscribeId forKey:@"id"];
    __weak typeof(self) weakSelf = self;
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [weakSelf keyedArchiverObject:responseObject toFile:YLSubscribeDetailPath];
            [weakSelf getLocationData];
            [NSString showMessage:@"加载完成"];
        } else {
            NSLog(@"%@", responseObject[@"message"]);
        }
    } failed:nil];
    
}

- (void)getLocationData {
    
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:YLSubscribeDetailPath];
    NSArray *models = [YLSubscribeDetailModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
    for (YLSubscribeDetailModel *model in models) {
        YLSubscribeCellFrame *cellFrame = [[YLSubscribeCellFrame alloc] init];
        cellFrame.model = model;
        [self.detailModels addObject:cellFrame];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailModels.count;
}

- (YLSubscribeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLSubscribeCell *cell = [YLSubscribeCell cellWithTableView:tableView];
    YLSubscribeCellFrame *cellFrame = self.detailModels[indexPath.row];
    cell.cellFrame = cellFrame;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLSubscribeCellFrame *cellFrame = self.detailModels[indexPath.row];
    YLSubscribeDetailModel *detailModel = cellFrame.model;
    YLTableViewModel *model = [YLTableViewModel mj_objectWithKeyValues:detailModel];
    YLDetailController *detail = [[YLDetailController alloc] init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLSubscribeCellFrame *cellFrame = self.detailModels[indexPath.row];
    return cellFrame.cellHeight;
}

- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"买车数据保存成功");
    } else {
        NSLog(@"保存失败");
    }
}

#pragma mark - Table view data source
- (void)setParams:(NSArray *)params {
    _params = params;
}

- (void)setModel:(YLSubscribeModel *)model {
    _model = model;
}

- (NSMutableArray<YLSubscribeCellFrame *> *)detailModels {
    if (!_detailModels) {
        _detailModels = [NSMutableArray array];
    }
    return _detailModels;
}
@end

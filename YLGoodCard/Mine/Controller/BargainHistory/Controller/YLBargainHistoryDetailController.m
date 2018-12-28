//
//  YLBargainHistoryDetailController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBargainHistoryDetailController.h"
#import "YLBargainHistoryDetailCell.h"
#import "YLBargainHistoryDetailHeader.h"
#import "YLBargainPriceView.h"
#import "YLRequest.h"
#import "YLAccount.h"
#import "YLAccountTool.h"
#import "YLBargainDetailModel.h"
#import "YLBargainDetailCellFrame.h"
#import "YLDetailController.h"

#define YLBargainHistoryDetailPath(carID) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"BargainHistoryDetail-%@", carID]]

@interface YLBargainHistoryDetailController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dickers;// 砍价者数量
@property (nonatomic, strong) UIView *cover;// 蒙版
@property (nonatomic, strong) YLBargainHistoryDetailHeader *header;
@property (nonatomic, strong) YLBargainPriceView *bargainPriceView;

@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *mark;
@property (nonatomic, strong) NSString *buyer;
@property (nonatomic, strong) NSString *seller;


@end

@implementation YLBargainHistoryDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"砍价记录详情";
    
    [self creatTableView];
    [self getLocalData];
    [self loadData];
}

- (void)loadData {
    
    YLAccount *account = [YLAccountTool account];
    NSString *urlString;
    if (self.isBuyer) {
        urlString = @"http://ucarjava.bceapp.com/bargain?method=binfo";
        self.mark = @"1";
    } else {
        urlString = @"http://ucarjava.bceapp.com/bargain?method=sinfo";
        self.mark = @"2";
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.model.detailId forKey:@"detailId"];
    [param setValue:account.telephone forKey:@"telephone"];
    __weak typeof(self) weakSelf = self;
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [weakSelf keyedArchiverObject:responseObject toFile:YLBargainHistoryDetailPath(weakSelf.model.detailId)];
            [weakSelf getLocalData];
        }
//        NSArray *array = [YLBargainDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        for (YLBargainDetailModel *model in array) {
//            model.isBuyer = self.isBuyer;
//            YLBargainDetailCellFrame *cellFrame = [[YLBargainDetailCellFrame alloc] init];
//            cellFrame.model = model;
//            [self.dickers addObject:cellFrame];
//        }
//        [self.tableView reloadData];
    } failed:nil];
}

- (void)getLocalData {
    
    [self.dickers removeAllObjects];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:YLBargainHistoryDetailPath(self.model.detailId)];
    NSArray *models = [YLBargainDetailModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
    for (YLBargainDetailModel *model in models) {
        model.isBuyer = self.isBuyer;
        YLBargainDetailCellFrame *cellFrame = [[YLBargainDetailCellFrame alloc] init];
        cellFrame.model = model;
        [self.dickers addObject:cellFrame];
    }
    [self.tableView reloadData];
}

- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"即将看车下架数据保存成功");
    } else {
        NSLog(@"保存失败");
    }
}

- (void)creatTableView {
    
    YLBargainHistoryDetailHeader *header = [[YLBargainHistoryDetailHeader alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 110)];
    header.model = self.model;
    __weak typeof(self) weakSelf = self;
    header.bargainHistoryBlock = ^(YLTableViewModel * _Nonnull model) {
        YLDetailController *detai = [[YLDetailController alloc] init];
        detai.model = model;
        [weakSelf.navigationController pushViewController:detai animated:YES];
    };
    self.header = header;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight - 110 + 44)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableHeaderView = self.header;
    
    [self.cover addSubview:self.bargainPriceView];
    [self.view addSubview:self.cover];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dickers.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLBargainDetailCellFrame *cellFrame = self.dickers[indexPath.row];
    
    YLBargainHistoryDetailCell *cell = [YLBargainHistoryDetailCell cellWithTableView:tableView];
    cell.cellFrame = cellFrame;
    
    
    YLBargainHistoryDetailCell *cell1 = [tableView cellForRowAtIndexPath:indexPath];
    CGPoint point = cell1.dickerBtn.center;
    point = [self.tableView convertPoint:point fromView:cell.dickerBtn.superview];
    NSIndexPath *indexPath1 = [self.tableView indexPathForRowAtPoint:point];
    YLBargainDetailCellFrame *cellFrame1 = self.dickers[indexPath1.row];
    __weak typeof(self) weakSelf = self;
    cell.dickerBlock = ^{ // 点击砍价
        weakSelf.cover.hidden = NO;
        weakSelf.bargainPriceView.buyerPrice = cellFrame1.model.price;
        weakSelf.bargainPriceView.sellerPrice = weakSelf.model.detail.price;
        weakSelf.buyer = cellFrame1.model.buyer;
        weakSelf.seller = cellFrame1.model.seller;
        weakSelf.bargainPriceView.isBuyer = weakSelf.isBuyer;
    };
    
    cell.accepBlock = ^{ // 点击接受
        NSString *urlString = @"http://ucarjava.bceapp.com/bargain?method=accept";
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:cellFrame1.model.detailId forKey:@"detailId"];
        [param setValue:cellFrame1.model.seller forKey:@"seller"];
        [param setValue:cellFrame1.model.buyer forKey:@"buyer"];
        [param setValue:weakSelf.model.detail.centerId forKey:@"centerId"];
        [param setValue:cellFrame1.model.bargainId forKey:@"id"];
        [param setValue:cellFrame1.model.price forKey:@"price"];
        [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
            NSLog(@"%@", responseObject);
            if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                NSLog(@" 接受价格请求成功");
                [weakSelf loadData];
            } else {
                NSLog(@"请求失败");
            }
        } failed:nil];
        
        if (weakSelf.bargainDetailBlock) {
            weakSelf.bargainDetailBlock();
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLBargainDetailCellFrame *cellFrame = self.dickers[indexPath.row];
    return cellFrame.cellHeight;
}

- (UIView *)cover {
    if (!_cover) {
        _cover = [[UIView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, YLScreenHeight - 64)];
        _cover.hidden = YES;
        _cover.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5];
    }
    return _cover;
}

- (NSMutableArray *)dickers {
    
    if (!_dickers) {
        _dickers = [NSMutableArray array];
    }
    return _dickers;
}

// 砍价视图-传出砍价、还价的价格
- (YLBargainPriceView *)bargainPriceView {
    if (!_bargainPriceView) {
        _bargainPriceView = [[YLBargainPriceView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 213 - 64, YLScreenWidth, 213)];
        __weak typeof(self) weakSelf = self;
        _bargainPriceView.bargainPriceBlock = ^(NSString * _Nonnull bargainPrice) {
            NSLog(@"bargainPrice:%@", bargainPrice);
            
            NSString *urlString = @"http://ucarjava.bceapp.com/bargain?method=dicker";
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:weakSelf.model.detailId forKey:@"detailId"];
            [param setValue:weakSelf.seller forKey:@"seller"];
            [param setValue:weakSelf.buyer forKey:@"buyer"];
            [param setValue:bargainPrice forKey:@"price"];
            [param setValue:weakSelf.mark forKey:@"mark"];
            [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
                NSLog(@"%@", responseObject);
                if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                    NSLog(@"请求成功");
                    [weakSelf loadData];
                } else {
                    NSLog(@"请求失败");
                }
            } failed:nil];
            if (weakSelf.bargainDetailBlock) {
                weakSelf.bargainDetailBlock();
            }

            
            
            
            
            weakSelf.price = bargainPrice;
            weakSelf.cover.hidden = YES;
        };
        _bargainPriceView.bargainPriceCancelBlock = ^{
            weakSelf.cover.hidden = YES;
        };
    }
    return _bargainPriceView;
}

- (void)setModel:(YLBargainHistoryModel *)model {
    _model = model;
}

@end

//
//  YLBuyController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//


#import "YLBuyController.h"
#import "YLSearchController.h"
#import "YLDetailController.h"
#import "YLBuyTableViewCell.h"
#import "YLLinkageView.h"
#import "YLCustomPrice.h"
#import "YLSelectView.h"
#import "YLSortView.h"
#import "YLBrandController.h"
#import "YLBuyCellFrame.h"
#import "YLNoneView.h"
#import "YLBuyTool.h"
#import "YLSearchParamModel.h"
#import "YLRequest.h"
#import "YLSearchParamView.h"
#import "YLHomeTool.h"
#import "YLTitleLinkageView.h"
#import "YLConditionParamView.h"

/*
 品牌列表
 */

#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height
#define YLTITLEHEIGHT 50

@interface YLBuyController () <UITableViewDelegate, UITableViewDataSource, YLLinkageViewDelegate, UIGestureRecognizerDelegate, YLCustomPriceDelegate>

@property (nonatomic, strong) YLLinkageView *linkageView;// 标题视图
@property (nonatomic, strong) YLTitleLinkageView *linkage;
@property (nonatomic, assign) BOOL isSelectLinkage;
@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, strong) UITableView *tableView;// 数据表
@property (nonatomic, strong) YLSortView *sortView;// 排序视图
@property (nonatomic, strong) YLCustomPrice *customPrice;// 价格视图
@property (nonatomic, strong) YLSelectView *selectView; // 筛选视图
@property (nonatomic, assign) BOOL isSelect;// 是否选中标题
@property (nonatomic, strong) UIView  *coverView;// 蒙板
@property (nonatomic, assign) BOOL isLarge;// 是否大图模式，默认是NO
@property (nonatomic, strong) YLNoneView *noneView;// 搜索为空显示的视图

@property (nonatomic, strong) YLSearchParamView *searchParamView; // 搜索参数视图
@property (nonatomic, strong) YLConditionParamView *conditionParamView; // 搜索参数显示的视图

@property (nonatomic, strong) NSMutableArray *recommends;// 推荐列表或者搜索列表
@property (nonatomic, strong) NSMutableArray *modelArray;// 存放数据模型的数组
@property (nonatomic, strong) YLBuyTableViewCell *cell;

//@property (nonatomic, strong) NSMutableArray *paramArray;
@property (nonatomic, strong) NSMutableDictionary *selectParam;// 网络请求的参数
@property (nonatomic, strong) NSMutableDictionary *params;// 网络请求的参数


@end

@implementation YLBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self setNav];
    [self addParamView];
    [self config];
    [self getParamArrayForParam];
    [self loadData];
}

- (void)config {
    // 添加标题
    [self.view addSubview:self.linkage];
    [self.view addSubview:self.tableView];
    // 添加蒙版
    [self.view addSubview:self.coverView];
    [self.coverView addSubview:self.sortView];
    [self.coverView addSubview:self.customPrice];
    [self.coverView addSubview:self.selectView];
    [self.view addSubview:self.noneView];
    
    self.coverView.hidden = YES;
    self.sortView.hidden = YES;
    self.customPrice.hidden = YES;
    self.selectView.hidden = YES;
    self.isSelect = NO;
    self.isLarge = NO;
    
    if (![self isBlankString:self.searchTitle]) {
        [self.titleBar setTitle:self.searchTitle forState:UIControlStateNormal];
    }
}

- (void)addParamView {
    YLConditionParamView *conditionParamView = [[YLConditionParamView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.linkage.frame), YLScreenWidth, 30)];
    __weak typeof(self) weakSelf = self;
    conditionParamView.conditionParamBlock = ^{
        weakSelf.conditionParamView.hidden = YES;
        CGRect rect = weakSelf.tableView.frame;
        rect.origin.y = rect.origin.y - 30;
        weakSelf.tableView.frame = rect;
        // 清空所有的参数，重新请求数据
        [weakSelf.selectParam removeAllObjects];
        [weakSelf.params removeAllObjects];
        [weakSelf loadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RECOVERTITLEVIEW" object:nil];
    };
    conditionParamView.removeBlock = ^(NSInteger index, NSString * _Nonnull title) {
      // 删除选中的参数，重新请求数据
        [weakSelf.params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSLog(@"key:%@-obj:%@", key, obj);
            if ([obj isEqualToString:title]) {
                NSLog(@"key:%@--title:%@", key, title);
                [weakSelf.params removeObjectForKey:key];
                [weakSelf.selectParam removeObjectForKey:key];
                [weakSelf loadData];
                *stop = YES;// 移除值之后结束枚举，避免越界造成崩溃
            }
        }];
    };
    self.conditionParamView = conditionParamView;
    [self.view addSubview:conditionParamView];
}

// 加载数据
- (void)loadData {
    // 获取搜索列表数据
    self.noneView.hidden = YES;
    
    NSString *urlString = @"http://ucarjava.bceapp.com/detail?method=search";
    [YLRequest GET:urlString parameters:self.selectParam success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"buyCar:%@", responseObject[@"message"]);
        } else {
//            NSLog(@"%@", responseObject);
            [self.recommends removeAllObjects];
            self.modelArray = [YLTableViewModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (YLTableViewModel *model in self.modelArray) {
                YLBuyCellFrame *cellFrame = [[YLBuyCellFrame alloc] init];
                cellFrame.isLargeImage = self.isLarge;
                cellFrame.model = model;
                [self.recommends addObject:cellFrame];
            }
            [self noneToSearchResult];
            [self.tableView reloadData];
        }
    } failed:nil];
    
}

#pragma mark 从请求参数中获取相应的值展示到视图上
- (void)getParamArrayForParam {
    
    NSArray *tempArray = [self.params allValues];
    if (tempArray.count > 0) {
        self.conditionParamView.params = tempArray;
        self.conditionParamView.hidden = NO;
        CGRect rect = CGRectMake(0, 64 + 50 + 30, YLScreenWidth, YLScreenHeight - 64 - 50 - 30);
        self.tableView.frame = rect;
    } else {
        self.conditionParamView.hidden = NO;
        CGRect rect = CGRectMake(0, 64 + 50, YLScreenWidth, YLScreenHeight - 64 - 50);
        self.tableView.frame = rect;
    }
}

// 加载更多数据
- (void)loadMoreData {
    
}

#pragma  私有方法
- (void)setNav {
    // 添加左右导航栏按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"阳江" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    [self.navigationItem.rightBarButtonItem setImage:[[UIImage imageNamed:@"看图模式"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.navigationController.navigationBar setBackgroundColor:YLColor(8.f, 169.f, 255.f)];
    // 设置导航栏背景为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 设置导航栏底部线条为空
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    // 修改导航标题
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // 创建一个假状态栏
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, YLScreenWidth, 20)];
    statusBarView.backgroundColor = YLColor(8.f, 169.f, 255.f);
    [self.navigationController.navigationBar addSubview:statusBarView];
    self.navigationItem.titleView = self.titleBar;
}

- (void)leftBarButtonItemClick {
    [self showMessage:@"暂只支持阳江地区"];
}

- (void)refreshHeader {
    NSLog(@"下拉刷新");
    [self loadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)refreshFooter {
    NSLog(@"上拉刷新");
    [self loadMoreData];
    [self.tableView.mj_footer endRefreshing];
}

- (void)titleClick {

    NSLog(@"title被点击了！");
    self.coverView.hidden = YES;
    self.isSelect = NO;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [YLHomeTool hotBrandWithParam:param success:^(NSDictionary * _Nonnull result) {
        NSMutableArray *hotBrands = (NSMutableArray *)result[@"data"][@"keyword"];
        YLSearchController *search = [[YLSearchController alloc] init];
        search.hotSearch = hotBrands;
        [self.navigationController pushViewController:search animated:YES];
    } failure:^(NSError * _Nonnull error) {
    }];
}

//- (void)leftBarButtonItemClick {
//
//    NSLog(@"leftBarButtonItem被点击了！");
//}

- (void)rightBarButtonItemClick {
    
    NSLog(@"切换大小图显示");
    self.isLarge = !self.isLarge;
    NSArray *temp = [NSArray arrayWithArray:self.recommends];
    [self.recommends removeAllObjects];
    for (YLBuyCellFrame *cellFrame in temp) {
        cellFrame.isLargeImage = self.isLarge;
        [self.recommends addObject:cellFrame];
    }
    [self.tableView reloadData];
}

// 如果搜索结果为空，那么显示noneView
- (void)noneToSearchResult {
    
    if (![self.recommends count]) {
        self.noneView.title = @"暂无搜索记录";
        self.noneView.hidden = NO;
        __weak typeof(self) weakSelf = self;
        self.noneView.noneViewBlock = ^{
            // 清空搜索条件
            [weakSelf.selectParam removeAllObjects];
            [weakSelf.params removeAllObjects];
            [weakSelf.titleBar setTitle:@"搜索您想要的车" forState:UIControlStateNormal];
            [weakSelf getParamArrayForParam];
            [weakSelf loadData];
            weakSelf.noneView.hidden = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RECOVERTITLEVIEW" object:nil];
        };
    }
}

// 判断字符串是否为空或者空格符
-  (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

// 提示弹窗
- (void)showMessage:(NSString *)message {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;// 获取最上层窗口
    
    UILabel *messageLabel = [[UILabel alloc] init];
    CGSize messageSize = CGSizeMake([message getSizeWithFont:[UIFont systemFontOfSize:12]].width + 30, 30);
    messageLabel.frame = CGRectMake((YLScreenWidth - messageSize.width) / 2, YLScreenHeight/2, messageSize.width, messageSize.height);
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = YLColor(233.f, 233.f, 233.f);
    messageLabel.layer.cornerRadius = 5.0f;
    messageLabel.layer.masksToBounds = YES;
    [window addSubview:messageLabel];
    
    [UIView animateWithDuration:1 animations:^{
        messageLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [messageLabel removeFromSuperview];
    }];
}

#pragma mark 代理
// 标题按钮点击的代理
//- (void)pushCoverView:(UIButton *)sender {
//
//    self.isSelect = !self.isSelect;
//    if (self.isSelect) {
//        if (sender.tag == 100) {
//            NSLog(@"排序");
//            self.coverView.hidden = NO;
//            self.sortView.hidden = NO;
//            self.customPrice.hidden = YES;
//            self.selectView.hidden = YES;
//        } else if (sender.tag == 101) {
//            NSLog(@"品牌");
//
//            self.coverView.hidden = YES;
//            self.sortView.hidden = YES;
//            self.customPrice.hidden = YES;
//            self.selectView.hidden = YES;
//            self.isSelect = NO;
//
//            __weak typeof(self) weakSelf = self;
//            YLBrandController *brand = [[YLBrandController alloc] init];
//            brand.buyBrandBlock = ^(NSString *brand, NSString *series) {
//                NSLog(@"%@-%@", brand, series);
//                [weakSelf.selectParam setValue:brand forKey:@"brand"];
//                [weakSelf.selectParam setValue:series forKey:@"series"];
//                NSLog(@"selectParam:%@", weakSelf.selectParam);
//                [weakSelf getParamArrayForParam];
//                [weakSelf loadData];
//            };
//            [self.navigationController pushViewController:brand animated:YES];
//
//        }else if (sender.tag == 102) {
//            NSLog(@"价格");
//            self.coverView.hidden = NO;
//            self.sortView.hidden = YES;
//            self.customPrice.hidden = NO;
//            self.selectView.hidden = YES;
//        }else {
//            NSLog(@"筛选");
//            [self showMessage:@"此功能以后再开放"];
//            self.isSelect = NO;
////            self.coverView.hidden = NO;
////            self.sortView.hidden = YES;
////            self.customPrice.hidden = YES;
////            self.selectView.hidden = NO;
//        }
//
//    } else {
//        self.coverView.hidden = YES;
//        self.sortView.hidden = YES;
//        self.customPrice.hidden = YES;
//        self.selectView.hidden = YES;
//    }
//}
#pragma mark 价格代理
// 价格视图里面的高价和低价代理
- (void)pushLowPrice:(NSString *)lowPrice highPrice:(NSString *)highPrice {

    self.coverView.hidden = YES;
    self.isSelect = NO;
    // 根据价格视图传过来的低价和高价，重新加载数据，刷新列表
    NSLog(@"%@--%@", lowPrice, highPrice);
    NSString *tempStr = [NSString stringWithFormat:@"%.ffgf%.f", [lowPrice floatValue] * 10000, [highPrice floatValue] * 10000];
    NSString *str = [NSString stringWithFormat:@"%@-%@万", lowPrice, highPrice];
    [self.selectParam setValue:tempStr forKey:@"price"];
    [self.params setValue:str forKey:@"price"];
    NSLog(@"selectParam:%@\nparams:%@", self.selectParam, self.params);
    [self getParamArrayForParam];
    [self loadData];
}

#pragma mark UItableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    YLBuyTableViewCell *cell = [YLBuyTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellFrame = self.recommends[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    YLBuyCellFrame *cellFrame = self.recommends[indexPath.row];
    YLDetailController *detailVc = [[YLDetailController alloc] init];
    detailVc.model = cellFrame.model;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    YLBuyCellFrame *cell = self.recommends[indexPath.row];
    return cell.cellHeight;
}



#pragma mark 懒加载
#pragma 外部传过来的参数
- (void)setParam:(NSMutableDictionary *)param {
    
    _param = [NSMutableDictionary dictionaryWithDictionary:param];
    NSLog(@"param:%@", param);
    
    // 保存请求参数
    // 清空原来的请求参数，添加传过来的参数
    [self.selectParam removeAllObjects];
    [self.selectParam addEntriesFromDictionary:param];
    [self loadData];
}

- (void)setTempParam:(NSMutableDictionary *)tempParam {
    _tempParam = [NSMutableDictionary dictionaryWithDictionary:tempParam];
    
    // 每次传过来的参数都要清空原参数
    [self.params removeAllObjects];
    [self.params addEntriesFromDictionary:tempParam];
    [self getParamArrayForParam];
}

- (YLLinkageView *)linkageView {
    
    if (!_linkageView) {
        _linkageView = [[YLLinkageView alloc] initWithFrame:CGRectMake(0, 64, YLScreenHeight, YLTITLEHEIGHT)];
        _linkageView.delegate = self;
    }
    return _linkageView;
}

- (YLTitleLinkageView *)linkage {
    if (!_linkage) {
        _linkage = [[YLTitleLinkageView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, 50)];
        __weak typeof(self) weakSelf = self;
        _linkage.linkageBlock = ^(NSInteger index) {
            weakSelf.isSelect = !weakSelf.isSelect;
            NSLog(@" weakSelf.isSelect:%d", weakSelf.isSelect);
            if (weakSelf.isSelect) {
                
                weakSelf.linkage.isSelect = weakSelf.isSelect; // 表示可更改颜色
                if (index == 0) {
                    NSLog(@"排序");
                    weakSelf.coverView.hidden = NO;
                    weakSelf.sortView.hidden = NO;
                    weakSelf.customPrice.hidden = YES;
                    weakSelf.selectView.hidden = YES;
                } else if (index == 1) {
                    NSLog(@"品牌");

                    weakSelf.coverView.hidden = YES;
                    weakSelf.sortView.hidden = YES;
                    weakSelf.customPrice.hidden = YES;
                    weakSelf.selectView.hidden = YES;
                    weakSelf.isSelect = NO;

                    YLBrandController *brand = [[YLBrandController alloc] init];
                    brand.buyBrandBlock = ^(NSString *brand, NSString *series) {
                        NSLog(@"%@-%@", brand, series);
                        [weakSelf.selectParam setValue:brand forKey:@"brand"];
                        [weakSelf.selectParam setValue:series forKey:@"series"];
                        [weakSelf.params setValue:brand forKey:@"brand"];
                        [weakSelf.params setValue:series forKey:@"series"];
                        NSLog(@"selectParam:%@\nparams:%@", weakSelf.selectParam, weakSelf.params);
                        [weakSelf getParamArrayForParam];
                        [weakSelf loadData];
                    };
                    [weakSelf.navigationController pushViewController:brand animated:YES];

                }else if (index == 2) {
                    NSLog(@"价格");
                    weakSelf.coverView.hidden = NO;
                    weakSelf.sortView.hidden = YES;
                    weakSelf.customPrice.hidden = NO;
                    weakSelf.selectView.hidden = YES;
                }else {
                    NSLog(@"筛选");
                    [weakSelf showMessage:@"此功能以后再开放"];
                    weakSelf.isSelect = NO;
                }

            } else {
                weakSelf.linkage.isSelect = weakSelf.isSelect; // 表示不可更改颜色
                weakSelf.coverView.hidden = YES;
                weakSelf.sortView.hidden = YES;
                weakSelf.customPrice.hidden = YES;
                weakSelf.selectView.hidden = YES;
            }
        };
    }
    return _linkage;
}

- (YLSortView *)sortView {
    
    if (!_sortView) {
        _sortView = [[YLSortView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
        __weak typeof(self) weakSelf = self;
        _sortView.sortViewBlock = ^(NSInteger index, NSString *title) {
            NSString *sort = [NSString stringWithFormat:@"%ld", index + 1];
            // 重新请求数据
            [weakSelf.selectParam setValue:sort forKey:@"sort"];
            [weakSelf.params setValue:title forKey:@"sort"];
            NSLog(@"selectParam:%@\nparams:%@", weakSelf.selectParam, weakSelf.params);
            [weakSelf getParamArrayForParam];
            [weakSelf loadData];
            weakSelf.coverView.hidden = YES;
            weakSelf.isSelect = NO;
        };
//        _sortView.delegate = self;
    }
    return _sortView;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, YLTITLEHEIGHT+65, YLScreenWidth, YLScreenHeight)];
        _coverView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    }
    return _coverView;
}

- (YLCustomPrice *)customPrice {
    if (!_customPrice) {
        _customPrice = [[YLCustomPrice alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 226)];
        _customPrice.backgroundColor = [UIColor whiteColor];
        _customPrice.delegate = self;
        __weak typeof(self) weakSelf = self;
        self.customPrice.customPriceBlock = ^(UIButton *sender) {
            NSLog(@"价格视图中的价格按钮被点击点击了%@", sender.titleLabel.text);
            weakSelf.coverView.hidden = YES;
            weakSelf.isSelect = NO;
            // 重新加载数据，刷新表格
            NSInteger tag = sender.tag - 100;
            NSArray *array = @[@"不限", @"三万以下", @"3-5万", @"5-7万", @"7-9万", @"9-12万", @"12-16万", @"16-20万", @"20万以上"];
            NSArray *array1 = @[@"", @"0fgf30000", @"30000fgf50000", @"50000fgf70000", @"70000fgf90000", @"90000fgf120000", @"120000fgf160000", @"160000fgf200000", @"200000fgf99999999"];
            // 添加请求参数
            [weakSelf.selectParam setValue:array1[tag] forKey:@"price"];
            [weakSelf.params setValue:array[tag] forKey:@"price"];
            NSLog(@"selectParam:%@\nparams:%@", weakSelf.selectParam, weakSelf.params);
            [weakSelf getParamArrayForParam];
            [weakSelf loadData];
        };
    }
    return _customPrice;
}

- (YLSelectView *)selectView {
    if (!_selectView) {
        _selectView = [[YLSelectView alloc] initWithFrame:CGRectMake(self.coverView.frame.size.width - 328, 0, 328, self.coverView.frame.size.height)];
        _selectView.backgroundColor = [UIColor redColor];
    }
    return _selectView;
}

- (NSMutableArray *)recommends {
    
    if (!_recommends) {
        _recommends = [NSMutableArray array];
    }
    return _recommends;
}

- (YLTitleBar *)titleBar {
    if (!_titleBar) {
        _titleBar = [[YLTitleBar alloc] initWithFrame:CGRectMake(0, 0, 260, 36)];
        [_titleBar setTitle:@"搜索您想要的车" forState:UIControlStateNormal];
        _titleBar.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleBar addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
        _titleBar.backgroundColor = YLColor(239.f, 242.f, 247.f);
        
    }
    return _titleBar;
}

- (NSMutableArray *)modelArray {
    
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (YLNoneView *)noneView {
    
    if (!_noneView) {
        _noneView = [[YLNoneView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, YLScreenHeight)];
        _noneView.hidden = YES;
        _noneView.backgroundColor = [UIColor whiteColor];
    }
    return _noneView;
}



#pragma 保存搜索条件参数的字典即请求的参数
- (NSMutableDictionary *)selectParam {
    if (!_selectParam) {
        _selectParam = [NSMutableDictionary dictionary];
    }
    return _selectParam;
}
- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

//- (NSMutableArray *)paramArray {
//    if (!_paramArray) {
//        _paramArray = [NSMutableArray array];
//    }
//    return _paramArray;
//}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 50, YLScreenWidth, YLScreenHeight-100)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    }
    return _tableView;
}

- (NSMutableArray *)labels {
    if (!_labels) {
        _labels = [NSMutableArray array];
    }
    return _labels;
}

- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

@end

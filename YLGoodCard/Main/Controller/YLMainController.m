//
//  YLMainController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//
/**
 1、轮播图
 2、成交记录
 3、热门品牌
 4、推荐列表
 5、热门品牌点击跳转买车页面
 6、热门头查看更多跳转买车页面
 */



#import "YLMainController.h"
#import "YLNavigationController.h"
#import "YLTabBarController.h"
#import "YLSearchController.h"
#import "YLDetailController.h"
#import "YLBuyController.h"
#import "YLMessageController.h"

#import "YLTableViewModel.h"
#import "YLSearchParamModel.h"
#import "YLRequest.h"
#import "YLHomeTool.h"

#import "YLTitleBar.h"
#import "YLTableViewCell.h"
#import "YLNotable.h"
#import "IXWheelV.h"
#import "YLHotCarView.h"

#define YLMainPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"main.plist"]

@interface YLMainController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *recommends; // 存放推荐类别
@property (nonatomic, copy) NSMutableArray *images; // 存放转播图的数组
@property (nonatomic, copy) NSMutableArray *notableTitles; // 存放走马灯广告

@property (nonatomic, strong) NSMutableDictionary *param;// 请求参数
@property (nonatomic, strong) NSMutableDictionary *tempParam;

@property (nonatomic, strong) YLNotable *notableView;// 成交记录轮播
@property (nonatomic, strong) IXWheelV *banner;
@property (nonatomic, strong) YLHotCarView *hotCar;

@property (nonatomic, strong) NSMutableDictionary *datas;// 存放数据的字典

@end

@implementation YLMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO; // 不自动调节滚动区域

    
    [self setNav];
    [self createTableView];
    
    [self loadData];
}

- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 130 + 60 + 44 + 99)];
    self.tableView.tableHeaderView = header;
    // 添加轮播图
    IXWheelV *banner = [[IXWheelV alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 130)];
    [header addSubview:banner];
    self.banner = banner;
    // 添加成交记录轮播广告
    YLNotable *notable = [[YLNotable alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(banner.frame), YLScreenWidth, 60)];
    [header addSubview:notable];
    self.notableView = notable;
    // 添加热门二手车
    __weak typeof(self) weakSelf = self;
    YLHotCarView *hotCar = [[YLHotCarView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(notable.frame), YLScreenWidth, 99 + 44)];
    hotCar.moreBlock = ^{ // 查看更多
        // 跳转到买车控制器
        YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        YLNavigationController *nav = tab.viewControllers[1];
        YLBuyController *buy = nav.viewControllers.firstObject;
        [weakSelf.param removeAllObjects];
        buy.param = weakSelf.param;
        [buy.titleBar setTitle:@"搜索您想要的车" forState:UIControlStateNormal];
        tab.selectedIndex = 1;
    };
    hotCar.brandBlock = ^(NSString * _Nonnull brand) {// 条件搜索
        // 判断传过来的字符串，如果是金额跳转到买车搜索，如果是品牌，同样
        // 点击列表，跳转买车控制器
        [weakSelf.param removeAllObjects];// 清空条件搜索
        [weakSelf.tempParam removeAllObjects];// 清空条件搜索
        YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        YLNavigationController *nav = tab.viewControllers[1];
        YLBuyController *buy = nav.viewControllers.firstObject;
        NSString *labelStr = brand;
        if ([labelStr isEqualToString:@"5万以下"]) {
            [weakSelf.param setValue:@"0fgf50000" forKey:@"price"];
            [weakSelf.tempParam setValue:labelStr forKey:@"price"];
        } else if ([labelStr isEqualToString:@"5-10万"]) {
            [weakSelf.param setValue:@"50000fgf100000" forKey:@"price"];
            [weakSelf.tempParam setValue:labelStr forKey:@"price"];
        } else if ([labelStr isEqualToString:@"10-15万"]) {
            [weakSelf.param setValue:@"100000fgf150000" forKey:@"price"];
            [weakSelf.tempParam setValue:labelStr forKey:@"price"];
        } else if ([labelStr isEqualToString:@"15万以上"]) {
            [weakSelf.param setValue:@"150000fgf99999999" forKey:@"price"];
            [weakSelf.tempParam setValue:labelStr forKey:@"price"];
        } else {
            [weakSelf.param setValue:labelStr forKey:@"brand"];
            [weakSelf.tempParam setValue:labelStr forKey:@"brand"];
        }
        buy.param = weakSelf.param;
        buy.tempParam = weakSelf.tempParam;
        tab.selectedIndex = 1;
    };
    [header addSubview:hotCar];
    self.hotCar = hotCar;
}

- (void)loadData {
    
    // 获取轮播图
    NSString *bannerStr = @"http://ucarjava.bceapp.com/home?method=slide";
    [YLRequest GET:bannerStr parameters:nil success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"bannerStr%@", responseObject[@"message"]);
        } else {
            [self.images removeAllObjects];
            NSArray *banners = [YLBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (YLBannerModel *model in banners) {
                if (!model.img) {
                    break;
                }
                [self.images addObject:model.img];
            }
//            NSLog(@"%@", self.images);
            self.banner.items = self.images;
        }
    } failed:nil];

    // 获取成交记录
    NSString *notableStr = @"http://ucarjava.bceapp.com/trade?method=random";
    [YLRequest GET:notableStr parameters:nil success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"notableStr%@", responseObject[@"message"]);
        } else {
            [self.notableTitles removeAllObjects];
            NSArray *notables = [YLNotableModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (YLNotableModel *model in notables) {
                NSString *notable = model.text;
                if (!notable) {
                    break;
                }
                [self.notableTitles addObject:notable];
            }
//            NSLog(@"%@", self.notableTitles);
            self.notableView.titles = self.notableTitles;
        }
    } failed:nil];
    
    // 获取推荐列表
    NSString *recommendStr = @"http://ucarjava.bceapp.com/detail?method=recommend";
    [YLRequest GET:recommendStr parameters:nil success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"recommendStr%@", responseObject[@"message"]);
        } else {
            [self.recommends removeAllObjects];
            NSArray *recomments = [YLTableViewModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (YLTableViewModel *model in recomments) {
                [self.recommends addObject:model];
            }
            [self.tableView reloadData];
        }
    } failed:nil];
}

- (void)getData {
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:YLMainPath];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:YLMainPath];
    if (!dict) {
        [self loadData];
    } else {
        
    }
//    NSDictionary *temp = [dict objectForKey:@"banner"];
//    NSLog(@"%@", temp);
//    NSArray *banners = [YLBannerModel mj_keyValuesArrayWithObjectArray:temp];
//    for (YLBannerModel *model in temp) {
//        if (!model.img) {
//            break;
//        }
//        [self.images addObject:model.img];
//    }
//    self.banner.items = self.images;
//
//    NSArray *trades = [YLNotableModel mj_keyValuesArrayWithObjectArray:dict[@"trade"]];
//    for (YLNotableModel *model in trades) {
//        if (!model.text) {
//            break;
//        }
//        [self.notableTitles addObject:model.text];
//    }
//    self.notableView.titles = self.notableTitles;
//
//    NSArray *recommends = [YLTableViewModel mj_keyValuesArrayWithObjectArray:dict[@"recommend"]];
//    for (YLTableViewModel *model in recommends) {
//        [self.recommends addObject:model];
//    }
//    [self.tableView reloadData];
    
}


- (void)loadMoreData {
    
    
}

- (void)headerRefresh {
    
    NSLog(@"下拉刷新");
    [self loadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)footerRefresh {
    
    NSLog(@"上拉刷新");
    [self loadMoreData];
//    [self.tableView.mj_footer endRefreshing];
}

#pragma mark UITableViewDataSource/UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
  
    return self.recommends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLTableViewCell *cell = [YLTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YLTableViewModel *model = self.recommends[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLTableViewModel *model = self.recommends[indexPath.row];
    YLDetailController *detail = [[YLDetailController alloc] init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}


#pragma mark 代理方法
// 点击首页热门二手车的查看更多
- (void)pushBuyControl {
    
    YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    YLNavigationController *nav = tab.viewControllers[1];
    YLBuyController *buy = nav.viewControllers.firstObject;
    [self.param removeAllObjects];
    buy.param = self.param;
    [buy.titleBar setTitle:@"搜索您想要的车" forState:UIControlStateNormal];
    tab.selectedIndex = 1;
}

#pragma mark Private
- (void)setNav {
    // 添加左右导航栏按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"阳江" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    [self.navigationController.navigationBar setBackgroundColor:YLColor(8.f, 169.f, 255.f)];
    // 设置导航栏背景为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 设置导航栏底部线条为空
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    // 修改导航标题
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    // 修改导航栏按钮字体颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 创建一个假状态栏
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, YLScreenWidth, 20)];
    statusBarView.backgroundColor = YLColor(8.f, 169.f, 255.f);
    [self.navigationController.navigationBar addSubview:statusBarView];
    
    // 设置导航栏搜索框按钮
    YLTitleBar *titleBtn = [[YLTitleBar alloc] initWithFrame:CGRectMake(0, 0, 260, 36)];
    [titleBtn setTitle:@"搜索您想要的车" forState:UIControlStateNormal];
    titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    titleBtn.backgroundColor = YLColor(239.f, 242.f, 247.f);
    [titleBtn addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}

- (void)titleClick {
    
    NSLog(@"title被点击了！");
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [YLHomeTool hotBrandWithParam:param success:^(NSDictionary * _Nonnull result) {
        NSMutableArray *hotBrands = (NSMutableArray *)result[@"data"][@"keyword"];
        YLSearchController *search = [[YLSearchController alloc] init];
        search.hotSearch = hotBrands;
        [self.navigationController pushViewController:search animated:YES];
    } failure:^(NSError * _Nonnull error) {
    }];
}
- (void)leftBarButtonItemClick {
    
    [self showMessage:@"暂时只支持阳江市"];
}

- (void)rightBarButtonItemClick {
    
    NSLog(@"消息中心被点击了！");
    YLMessageController *messageVc = [[YLMessageController alloc] init];
    [self.navigationController pushViewController:messageVc animated:YES];
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

#pragma mark 懒加载
- (NSMutableArray *)recommends {
    if (!_recommends) {
        _recommends = [NSMutableArray array];
    }
    return _recommends;
}

- (NSMutableArray *)images {
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (NSMutableArray *)notableTitles {
    if (!_notableTitles) {
        _notableTitles = [NSMutableArray array];
    }
    return _notableTitles;
}


- (NSMutableDictionary *)param {
    if (!_param) {
        _param = [NSMutableDictionary dictionary];
    }
    return _param;
}

- (NSMutableDictionary *)tempParam {
    
    if (!_tempParam) {
        _tempParam = [NSMutableDictionary dictionary];
    }
    return _tempParam;
}

- (NSMutableDictionary *)datas {
    if (!_datas) {
        _datas = [NSMutableDictionary dictionary];
    }
    return _datas;
}
@end

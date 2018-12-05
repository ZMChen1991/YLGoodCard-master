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

#import "YLTitleBar.h"
#import "YLTableViewCell.h"
#import "YLMessageController.h"
#import "YLHomeHeader.h"
#import "YLTableViewModel.h"
#import "YLBuyController.h"
#import "YLHomeTool.h"
#import "YLSearchParamModel.h"
#import "YLRequest.h"

#import "SDCycleScrollView.h"
#import "YLNotable.h"





@interface YLMainController ()<UITableViewDelegate, UITableViewDataSource, YLButtonViewDelegate, YLTableGroupHeaderDelegate>

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *recommends; // 存放推荐类别
@property (nonatomic, copy) NSMutableArray *images; // 存放转播图的数组
@property (nonatomic, copy) NSMutableArray *notableTitles; // 存放走马灯广告

@property (nonatomic, strong) NSMutableDictionary *param;

// -----------------------------------------------------------
@property (nonatomic, strong) SDCycleScrollView *scrollView;// 图片轮播
@property (nonatomic, strong) YLNotable *notableView;// 成交记录轮播




@end

@implementation YLMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO; // 不自动调节滚动区域

    
//    [self loadData];
//    [self setNav];
//    [self setupTableView];
    
//    [self test];
}

- (void)test {
    
    // 获取轮播图
    NSString *bannerStr = @"http://ucarjava.bceapp.com/home?method=slide";
    [YLRequest GET:bannerStr parameters:nil success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"bannerStr%@", responseObject[@"message"]);
        } else {
            NSArray *banners = [YLBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (YLBannerModel *model in banners) {
                [self.images addObject:model];
            }
            NSLog(@"%@", self.images);
            
            CGRect scrollFrame = CGRectMake(0, 0, YLScreenWidth, 220);
            self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:scrollFrame imageURLStringsGroup:self.images];
        }
    } failed:nil];
    
    // 获取成交记录
    NSString *notableStr = @"http://ucarjava.bceapp.com/trade?method=random";
    [YLRequest GET:notableStr parameters:nil success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"notableStr%@", responseObject[@"message"]);
        } else {
            NSLog(@"notableStr%@", responseObject[@"data"]);
            NSArray *notables = [YLNotableModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (YLNotableModel *model in notables) {
                NSString *notable = model.text;
                [self.notableTitles addObject:notable];
            }
            NSLog(@"%@", self.notableTitles);
            
            CGRect notableFrame = CGRectMake(0, 220, YLScreenWidth, 60);
            self.notableView = [[YLNotable alloc] initWithWithFrame:notableFrame titles:self.notableTitles];
        }
    } failed:nil];
    
    [self createTableView];
}

- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 280)];
    [header addSubview:self.scrollView];
    [header addSubview:self.notableView];
    self.tableView.tableHeaderView = header;

}



- (void)loadData {
    
    // 获取轮播图
    NSString *bannerStr = @"http://ucarjava.bceapp.com/home?method=slide";
    [YLRequest GET:bannerStr parameters:nil success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"bannerStr%@", responseObject[@"message"]);
        } else {
            NSLog(@"bannerStr%@", responseObject[@"data"]);
            NSArray *banners = [YLBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (YLBannerModel *model in banners) {
                [self.images addObject:model];
            }
            NSLog(@"%@", self.images);
        }
    } failed:nil];

    // 获取成交记录
    NSString *notableStr = @"http://ucarjava.bceapp.com/trade?method=random";
    [YLRequest GET:notableStr parameters:nil success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"notableStr%@", responseObject[@"message"]);
        } else {
            NSLog(@"notableStr%@", responseObject[@"data"]);
            NSArray *notables = [YLNotableModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (YLNotableModel *model in notables) {
                NSString *notable = model.text;
                [self.notableTitles addObject:notable];
            }
            NSLog(@"%@", self.notableTitles);
        }
    } failed:nil];
    
    // 获取推荐列表
    NSString *recommendStr = @"http://ucarjava.bceapp.com/detail?method=recommend";
    [YLRequest GET:recommendStr parameters:nil success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"recommendStr%@", responseObject[@"message"]);
        } else {
            NSLog(@"recommendStr%@", responseObject[@"data"]);
            NSArray *recomments = [YLTableViewModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (YLTableViewModel *model in recomments) {
                [self.recommends addObject:model];
            }
            [self.tableView reloadData];
        }
    } failed:nil];
}

- (void)loadMoreData {
    
    
}


- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.bounces = NO; // 禁止弹跳
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
//    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    

    CGRect frame = CGRectMake(0, 100, YLScreenWidth, 424);
    YLHomeHeader *homeHeader = [[YLHomeHeader alloc] initWithFrame:frame bannerTitles:self.images notabletitles:self.notableTitles];
    homeHeader.groupHeader.delegate = self;
    
    __weak typeof(self) weakSelf = self;
    // block
    homeHeader.buttonView.tapClickBlock = ^(UILabel *label) {
        NSLog(@"YLMainController:%@", label.text);
        // 点击列表，跳转买车控制器
        YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        YLNavigationController *nav = tab.viewControllers[1];
        YLBuyController *buy = nav.viewControllers.firstObject;
        NSString *labelStr = label.text;
        if ([labelStr isEqualToString:@"5万以下"]) {
            [weakSelf.param setValue:@"0fgf50000" forKey:@"price"];
        } else if ([labelStr isEqualToString:@"5-10万"]) {
            [weakSelf.param setValue:@"50000fgf100000" forKey:@"price"];
        } else if ([labelStr isEqualToString:@"10-15万"]) {
            [weakSelf.param setValue:@"100000fgf150000" forKey:@"price"];
        } else if ([labelStr isEqualToString:@"15万以上"]) {
            [weakSelf.param setValue:@"150000fgf99999999" forKey:@"price"];
        } else {
            [weakSelf.param setValue:labelStr forKey:@"brand"];
        }
        buy.param = weakSelf.param;
        [buy.titleBar setTitle:labelStr forState:UIControlStateNormal];
        tab.selectedIndex = 1;
        [weakSelf.param removeAllObjects];
    };
    self.tableView.tableHeaderView = homeHeader;
}

- (void)headerRefresh {
    
    NSLog(@"下拉刷新");
    [self.recommends removeAllObjects];
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
//// 这里是条件搜索框里的按钮代理方法，根据标题跳转到搜索框搜索相关的车辆
//- (void)selectBtnTitle:(NSString *)title {
//
//    NSLog(@"%@", title);
//    YLSearchController *search = [[YLSearchController alloc] init];
//    search.searchTitle = title;
//    [self.navigationController pushViewController:search animated:YES];
//}
//
//// 查看更多
//- (void)checkMore {
//    
//    NSLog(@"YLMainController:checkMore");
//    YLSearchController *searchVc = [[YLSearchController alloc] init];
//    [self.navigationController pushViewController:searchVc animated:YES];
//}

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
    
//    // 设置导航栏透明
//    [self.navigationController.navigationBar setTranslucent:YES];
////    // 设置导航栏背景为空
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    // 设置导航栏底部线条为空
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    // 添加左右导航栏按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"阳江" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"..." style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
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

@end

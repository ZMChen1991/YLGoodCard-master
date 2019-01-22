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
#import "YLAboutController.h"
#import "YLBarButton.h"
#import "YLBarView.h"
#import "YLTableViewCellFrame.h"
#import "YLBuyConditionModel.h"
#import "YLBannerCollectionView.h"

#define YLMainPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"main.txt"]
#define YLBannerPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"banner.txt"]
#define YLNotablePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"notable.txt"]

@interface YLMainController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *recommends; // 存放推荐类别
@property (nonatomic, copy) NSMutableArray *images; // 存放转播图的数组
@property (nonatomic, copy) NSMutableArray *notableTitles; // 存放走马灯广告

@property (nonatomic, strong) NSMutableDictionary *param;// 请求参数
@property (nonatomic, strong) NSMutableDictionary *tempParam;

@property (nonatomic, strong) YLNotable *notableView;// 成交记录轮播
@property (nonatomic, strong) IXWheelV *banner;
//@property (nonatomic, strong) YLBannerCollectionView *banner;
@property (nonatomic, strong) YLHotCarView *hotCar;

@property (nonatomic, strong) NSMutableDictionary *datas;// 存放数据的字典
//@property (nonatomic, strong) YLDetailController *detail;

@end

@implementation YLMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO; // 不自动调节滚动区域
    
    [self setNav];
    [self createTableView];
//    NSLog(@"%f-%f %f-%f--%f %f",self.tableView.frame.origin.x,self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height, self.tableView.contentOffset.x, self.tableView.contentOffset.y);
    
    [self getLocationData];
    [self loadData];
}

- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight - 64)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 130 + 60 + 44 + 99)];
    self.tableView.tableHeaderView = header;
    // 添加轮播图
    IXWheelV *banner = [[IXWheelV alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 130)];
    __weak typeof(self) weakSelf = self;
    banner.bannerBlock = ^{
        YLAboutController *about = [[YLAboutController alloc] init];
        [weakSelf.navigationController pushViewController:about animated:YES];
    };
    [header addSubview:banner];
    self.banner = banner;
    
//    YLBannerCollectionView *banner = [[YLBannerCollectionView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 130 + 60 + 44 + 99)];
//    [header addSubview:banner];
//    self.banner = banner;
    
    // 添加成交记录轮播广告
    YLNotable *notable = [[YLNotable alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(banner.frame), YLScreenWidth, 60)];
    [header addSubview:notable];
    self.notableView = notable;
    // 添加热门二手车
//    __weak typeof(self) weakSelf = self;
    YLHotCarView *hotCar = [[YLHotCarView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(notable.frame), YLScreenWidth, 99 + 44)];
    hotCar.moreBlock = ^{ // 查看更多
        // 跳转到买车控制器
        YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        YLNavigationController *nav = tab.viewControllers[1];
        YLBuyController *buy = nav.viewControllers.firstObject;
        YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
        buy.paramModel = model;
        [buy.titleBar setTitle:@"搜索您想要的车" forState:UIControlStateNormal];
        tab.selectedIndex = 1;
    };
    hotCar.brandBlock = ^(NSString * _Nonnull brand) {// 条件搜索
        // 判断传过来的字符串，如果是金额跳转到买车搜索，如果是品牌，同样
        // 点击列表，跳转买车控制器
//        [weakSelf.param removeAllObjects];// 清空条件搜索
//        [weakSelf.tempParam removeAllObjects];// 清空条件搜索
        YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        YLNavigationController *nav = tab.viewControllers[1];
        YLBuyController *buy = nav.viewControllers.firstObject;
        NSString *labelStr = brand;
        YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
        model.isSelect = YES;
        if ([labelStr isEqualToString:@"5万以下"]) {
            model.title = labelStr;
            model.detail = labelStr;
            model.param = @"0fgf50000";
            model.key = @"price";
        } else if ([labelStr isEqualToString:@"5-10万"]) {
            model.title = labelStr;
            model.detail = labelStr;
            model.param = @"50000fgf100000";
            model.key = @"price";
        } else if ([labelStr isEqualToString:@"10-15万"]) {
            model.title = labelStr;
            model.detail = labelStr;
            model.param = @"100000fgf150000";
            model.key = @"price";
        } else if ([labelStr isEqualToString:@"15万以上"]) {
            model.title = labelStr;
            model.detail = labelStr;
            model.param = @"150000fgf99999999";
            model.key = @"price";
        } else {
            model.title = labelStr;
            model.detail = labelStr;
            model.param = labelStr;
            model.key = @"brand";
        }
        buy.paramModel = model;
        tab.selectedIndex = 1;
    };
    [header addSubview:hotCar];
    self.hotCar = hotCar;
}

- (void)getLocationData {
    
    [self.images removeAllObjects];
    [self.notableTitles removeAllObjects];
    [self.recommends removeAllObjects];
    
    NSDictionary *banner = [NSKeyedUnarchiver unarchiveObjectWithFile:YLBannerPath];
    NSArray *banners = [YLBannerModel mj_objectArrayWithKeyValuesArray:banner[@"data"]];
    for (YLBannerModel *model in banners) {
        if (!model.img) {
            break;
        }
        [self.images addObject:model.img];
    }
//    self.banner.images = self.images;
    self.banner.items = self.images;
//    NSLog(@"banner:%@", banner);
    
    NSDictionary *notable = [NSKeyedUnarchiver unarchiveObjectWithFile:YLNotablePath];
    NSArray *notables = [YLNotableModel mj_objectArrayWithKeyValuesArray:notable[@"data"]];
    for (YLNotableModel *model in notables) {
        NSString *notable = model.text;
        if (!notable) {
            break;
        }
        [self.notableTitles addObject:notable];
    }
    self.notableView.titles = self.notableTitles;
    
    NSDictionary *recomment = [NSKeyedUnarchiver unarchiveObjectWithFile:YLMainPath];
    NSArray *recomments = [YLTableViewModel mj_objectArrayWithKeyValuesArray:recomment[@"data"]];
    for (YLTableViewModel *model in recomments) {
        YLTableViewCellFrame *cellFrame = [[YLTableViewCellFrame alloc] init];
        cellFrame.model = model;
        [self.recommends addObject:cellFrame];
    }
    [self.tableView reloadData];
}

- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"首页数据保存成功");
    } else {
        NSLog(@"保存失败");
    }
}

- (void)loadData {
    
    // 获取轮播图
    NSString *bannerStr = @"http://ucarjava.bceapp.com/home?method=slide";
    __weak typeof(self) weakSelf = self;
    [YLRequest GET:bannerStr parameters:nil success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"bannerStr%@", responseObject[@"message"]);
        } else {
            [weakSelf keyedArchiverObject:responseObject toFile:YLBannerPath];
            [weakSelf getLocationData];
        }
    } failed:nil];

    // 获取成交记录
    NSString *notableStr = @"http://ucarjava.bceapp.com/trade?method=random";
    [YLRequest GET:notableStr parameters:nil success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"notableStr%@", responseObject[@"message"]);
        } else {
            [weakSelf keyedArchiverObject:responseObject toFile:YLNotablePath];
            [weakSelf getLocationData];
            
        }
    } failed:nil];
    
    // 获取推荐列表
    NSString *recommendStr = @"http://ucarjava.bceapp.com/detail?method=recommend";
    [YLRequest GET:recommendStr parameters:nil success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"recommendStr%@", responseObject[@"message"]);
        } else {
            [weakSelf keyedArchiverObject:responseObject toFile:YLMainPath];
            [weakSelf getLocationData];
        }
    } failed:nil];
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
    YLTableViewCellFrame *cellFrame = self.recommends[indexPath.row];
    cell.cellFrame = cellFrame;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    YLTableViewModel *model = self.recommends[indexPath.row];
    YLTableViewCellFrame *cellFrame = self.recommends[indexPath.row];
    YLTableViewModel *model = cellFrame.model;
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
    YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
//    [self.param removeAllObjects];
    buy.paramModel = model;
    [buy.titleBar setTitle:@"搜索您想要的车" forState:UIControlStateNormal];
    tab.selectedIndex = 1;
}

#pragma mark Private
- (void)setNav {
    // 添加左右导航栏按钮
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"阳江" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    YLBarButton *barButton = [YLBarButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0, 0, 45, 44);
    barButton.title = @"阳江";
    barButton.icon = @"地区下拉";
    [barButton addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    // 修改导航标题
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 255, 44)];
    YLBarView *barView = [[YLBarView alloc] initWithFrame:CGRectMake(10, (44 - 36) / 2, 255, 36)];
    barView.layer.cornerRadius = 5.f;
    barView.layer.masksToBounds = YES;
    barView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    barView.icon = @"搜索";
    barView.title = @"搜索您想要的车";
    __weak typeof(self) weakSelf = self;
    barView.barViewBlock = ^{
        NSLog(@"点击了barView标题视图");
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [YLHomeTool hotBrandWithParam:param success:^(NSDictionary * _Nonnull result) {
            NSMutableArray *hotBrands = (NSMutableArray *)result[@"data"][@"keyword"];
            YLSearchController *search = [[YLSearchController alloc] init];
            search.hotSearch = hotBrands;
            [weakSelf.navigationController pushViewController:search animated:YES];
        } failure:^(NSError * _Nonnull error) {
        }];
    };
    [view addSubview:barView];
//    [barView sizeThatFits:CGSizeMake(250, 36)];
    self.navigationItem.titleView = view;
    
    [self setNavgationBarBackgroundImage];
}

- (void)setNavgationBarBackgroundImage {
    CGGradientRef gradient;// 颜色的空间
    size_t num_locations = 2;// 渐变中使用的颜色数
    CGFloat locations[] = {0.0, 1.0}; // 指定每个颜色在渐变色中的位置，值介于0.0-1.0之间, 0.0表示最开始的位置，1.0表示渐变结束的位置
    CGFloat colors[] = {
        13.0/255.0, 196.f/255.f, 255.f/255, 1.0,
        3.0/255.0, 141.f/255.f, 255.f/255, 1.0,
    }; // 指定渐变的开始颜色，终止颜色，以及过度色（如果有的话）
    gradient = CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(), colors, locations, num_locations);
    CGPoint startPoint = CGPointMake(0.0, 0.0);
    CGPoint endPoint = CGPointMake(self.view.frame.size.width, 1.0);
    CGSize size = CGSizeMake(self.view.frame.size.width, 1.0);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"%f-%f", image.size.width, image.size.height);
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
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
    CGSize messageSize = CGSizeMake([message getSizeWithFont:[UIFont systemFontOfSize:12]].width + 50, 50);
    messageLabel.frame = CGRectMake((YLScreenWidth - messageSize.width) / 2, YLScreenHeight/2, messageSize.width, messageSize.height);
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = YLColor(233.f, 233.f, 233.f);
    messageLabel.layer.cornerRadius = 5.0f;
    messageLabel.layer.masksToBounds = YES;
    [window addSubview:messageLabel];
    [UIView animateWithDuration:2 animations:^{
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

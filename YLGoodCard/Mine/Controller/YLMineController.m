//
//  YLMineController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//
/**
 1、登录
 2、即将看车
 3、我的收藏
 4、浏览记录
 5、买车订单
 6、卖车订单
 7、砍价记录
 */


#import "YLMineController.h"
#import "YLDetailController.h"
#import "YLSuggestionController.h"
#import "YLLoginController.h"
#import "YLSettingController.h"
#import "YLFunctionController.h"
#import "YLSubController.h"
#import "YLBrowseController.h"
#import "YLCollectController.h"
#import "YLSaleOrderController.h"
#import "YLBuyOrderController.h"
#import "YLBargainHistoryController.h"
#import "YLDepreciateController.h"

#import "YLTableGroupHeader.h"
#import "YLFunctionView.h"
#import "YLTableViewCell.h"
#import "YLMineIcon.h"
#import "YLLoginHeader.h"


#import "YLAccount.h"
#import "YLAccountTool.h"
#import "YLMineTool.h"

// 浏览记录路径
#define YLBrowsingHistoryPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"browsingHistory.plist"]

@interface YLMineController () <YLFunctionViewDelegate, YLLoginHeaderDelegate, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YLLoginController *loginVc;
@property (nonatomic, strong) YLLoginHeader *loginHeader;
@property (nonatomic, strong) YLMineIcon *mineIcon;
@property (nonatomic, strong) YLFunctionView *functionView;

@property (nonatomic, strong) YLAccount *account;
@property (nonatomic, strong) NSMutableArray *browsingHistory;
@property (nonatomic, assign) NSInteger browsingHistoryCount;


@property (nonatomic, strong) NSArray *array;

@end

@implementation YLMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = @[@"电话客服", @"意见反馈"];
    
    [self setupNav];
    [self setupUI];
    
    self.account = [YLAccountTool account];
    if (self.account) {
        self.isLogin = YES;
        self.mineIcon.telephone = self.account.telephone;
        self.mineIcon.hidden = NO;
        self.loginHeader.hidden =YES;
        [self loadDate];
    } else {
        self.isLogin = NO;
        self.mineIcon.hidden = YES;
        self.loginHeader.hidden =NO;
    }
    
    [self addNotification];
}

#pragma mark 加载即将看车、我的收藏、浏览记录、砍价数量
- (void)loadDate {
    
    // 获取本地浏览记录个数
    self.browsingHistoryCount = self.browsingHistory.count;
    NSLog(@"count:%ld", self.browsingHistoryCount);
    
    if (self.account) {
        // 获取我的收藏个数
        NSMutableDictionary *param1 = [NSMutableDictionary dictionary];
        [param1 setValue:self.account.telephone forKey:@"telephone"];
        [param1 setValue:[NSDate date] forKey:@"nowTime"];
        [param1 setValue:@"" forKey:@"lastTime"];
        [YLMineTool favoriteWithParam:param1 success:^(NSDictionary * _Nonnull result) {
            //        NSLog(@"%@", result);
            // 即将看车数：
            NSString *book = [result valueForKey:@"book"];
            // 收藏数：
            NSString *collect = [result valueForKey:@"collection"];
            // 降价提醒数：
            NSString *reduce = [result valueForKey:@"reduce"];
            NSLog(@"book:%@--collect:%@--reduce:%@", book, collect, reduce);
            NSMutableArray *mineArray = [NSMutableArray array];
            [mineArray addObject:book];
            [mineArray addObject:collect];
            [mineArray addObject:[NSString stringWithFormat:@"%ld", self.browsingHistoryCount]];
            [mineArray addObject:@"0"];
            self.functionView.numbers = mineArray;
        } failure:nil];
    } else {
        NSString *count = [NSString stringWithFormat:@"%ld", self.browsingHistoryCount];
        NSMutableArray *mineArray = [NSMutableArray arrayWithObjects:@"0", @"0", count, @"0", nil];
        self.functionView.numbers = mineArray;
    }
}

#pragma mark UI
- (void)setupUI {
    
    self.mineIcon = [[YLMineIcon alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, 96)];
    self.mineIcon.backgroundColor = YLColor(8.f, 169.f, 255.f);
    [self.view addSubview:self.mineIcon];
    
    self.loginHeader = [[YLLoginHeader alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, 96)];
    self.loginHeader.backgroundColor = YLColor(8.f, 169.f, 255.f);
    self.loginHeader.delegate = self;
    [self.view addSubview:self.loginHeader];
    
    YLFunctionView *functionView = [[YLFunctionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.loginHeader.frame), YLScreenWidth, 176 + 1)];
    functionView.delegate = self;
    [self.view addSubview:functionView];
    self.functionView = functionView;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(functionView.frame), YLScreenWidth, YLScreenHeight - CGRectGetMaxY(functionView.frame))];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
}


- (void)setupNav {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    [self.navigationItem.rightBarButtonItem setImage:[[UIImage imageNamed:@"设置"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
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
}

- (void)rightBarButtonItemClick {
    NSLog(@"点击了设置按钮");
    
    YLSettingController *setting = [[YLSettingController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:@"REFRESHTABLEVIEW" object:nil];
}

- (void)refreshTableView {
    
    NSLog(@"接受到消息");
    [self loadDate];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"YLMineController";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.array[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self callTelephone];
    } else {
        [self suggestions];
    }
}

#pragma mark 代理
- (void)numberViewClickInIndex:(NSInteger)index {
    
    NSArray *array = @[@"即将看车",@"我的收藏", @"浏览记录", @"我的订阅"];
    NSLog(@"点击了%@跳转%@控制器", array[index], array[index]);
    
    if (index == 0) {
        NSArray *titles = @[@"在售", @"已下架"];
//        NSMutableDictionary *param = [NSMutableDictionary dictionary];
//        [param setValue:self.account.telephone forKey:@"telephone"];
//        [param setValue:@"1" forKey:@"status"]; // 1：待约定 2：合同签署 3：复检过户 4：交易完成
        NSArray *params = @[@"1", @"4"];
        YLFunctionController *fun = [[YLFunctionController alloc] init];
        fun.title = array[index];
        fun.titles = titles;
        fun.params = params;
        [self.navigationController pushViewController:fun animated:YES];
        return;
    }
    if (index == 1) {
        NSArray *titles = @[@"在售", @"已下架"];
        NSArray *params = @[@"3", @"0"];
        YLCollectController *collect = [[YLCollectController alloc] init];
        collect.title = array[index];
        collect.titles = titles;
        collect.params = params;
        [self.navigationController pushViewController:collect animated:YES];
        return;
    }
    if (index == 2) {
        YLBrowseController *browse = [[YLBrowseController alloc] init];
        browse.title = array[index];
        [self.navigationController pushViewController:browse animated:YES];
    }
    if (index == 3) {
        [self showMessage:@"开发中,敬请期待"];
        return;
    }
}

- (void)skipToLogin {
    
    NSLog(@"点击了登录按钮");
    [self.navigationController pushViewController:self.loginVc animated:YES];
    __weak typeof(self) weakSelf = self;
    self.loginVc.loginBlock = ^(NSString *string) {
        NSLog(@"mineVC:%@", string);
        weakSelf.isLogin = YES;
    };
}

- (void)btnClickToController:(UIButton *)sender {
    
    // 这里判断用户是否登录，如果没有则跳转登录界面
    YLAccount *account = [YLAccountTool account];
    if(account) {
        NSLog(@"已登录");
        NSLog(@"%@",sender.titleLabel.text);
        NSInteger index = sender.tag - 100;
        NSString *title = sender.titleLabel.text;
        NSArray *array = @[@"卖车订单", @"买车订单", @"砍价记录", @"降价提醒"];
        if (index == 0) {
            NSLog(@"%@----卖车订单", title);
            NSArray *titles = @[@"全部", @"待上架",@"售卖中", @"已售出",@"已下架"];
            NSArray *params = @[@"", @"1", @"3", @"4", @"0"];
            YLSaleOrderController *saleOrder = [[YLSaleOrderController alloc] init];
            saleOrder.title = array[index];
            saleOrder.titles = titles;
            saleOrder.params = params;
            [self.navigationController pushViewController:saleOrder animated:YES];
            return;
        }
        if (index == 1) {
            NSLog(@"%@=----买车订单", title);
            NSArray *titles = @[@"全部", @"待复检过户",@"交易完成"];
            NSArray *params = @[@"", @"3", @"4"];
            YLBuyOrderController *buyOrder = [[YLBuyOrderController alloc] init];
            buyOrder.title = array[index];
            buyOrder.titles = titles;
            buyOrder.params = params;
            [self.navigationController pushViewController:buyOrder animated:YES];
            return;
        }
        if (index == 2) {
            NSLog(@"%@=--=-砍价记录", title);
            NSArray *titles = @[@"买家", @"卖家"];
            YLBargainHistoryController *bargainHistory = [[YLBargainHistoryController alloc] init];
            bargainHistory.title = array[index];
            bargainHistory.titles = titles;
            [self.navigationController pushViewController:bargainHistory animated:YES];
        }
        if (index == 3) {
            NSLog(@"降价提醒");
            YLDepreciateController *depreciate = [[YLDepreciateController alloc] init];
            [self.navigationController pushViewController:depreciate animated:YES];
        }
    } else {
        NSLog(@"没有登录");
        [self.navigationController pushViewController:self.loginVc animated:YES];
    }
}

- (void)callTelephone {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"13800138000" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    alert.delegate = self;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex:%ld", buttonIndex);
    if (buttonIndex == 1) {
        [self test];
        NSLog(@"拨打电话");
    }
}

- (void)test {
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", @"10086"];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}

- (void)suggestions {
    
    NSLog(@"弹出意见反馈页面");
    YLSuggestionController *suggestionVc = [[YLSuggestionController alloc] init];
    [self.navigationController pushViewController:suggestionVc animated:YES];
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
- (YLLoginController *)loginVc {
    if (!_loginVc) {
        _loginVc = [[YLLoginController alloc] init];
    }
    return _loginVc;
}

- (NSMutableArray *)browsingHistory {
    
    if (!_browsingHistory) {
        NSLog(@"%@", YLBrowsingHistoryPath);
        _browsingHistory = [NSKeyedUnarchiver unarchiveObjectWithFile:YLBrowsingHistoryPath];
        if (!_browsingHistory) {
            _browsingHistory = [NSMutableArray array];
        }
    }
    return _browsingHistory;
}

- (NSInteger)browsingHistoryCount {
    if (!_browsingHistoryCount) {
        _browsingHistoryCount = self.browsingHistory.count;
    }
    return _browsingHistoryCount;
}

- (void)setIsLogin:(BOOL)isLogin {
    _isLogin = isLogin;
    if (isLogin) {
        self.account = [YLAccountTool account];
        self.mineIcon.telephone = self.account.telephone;
        self.mineIcon.hidden = NO;
        self.loginHeader.hidden = YES;
        [self loadDate];
    } else {
        self.mineIcon.hidden = YES;
        self.loginHeader.hidden = NO;
        NSString *count = [NSString stringWithFormat:@"%ld", self.browsingHistoryCount];
        NSMutableArray *mineArray = [NSMutableArray arrayWithObjects:@"0", @"0", count, @"0", nil];
        self.functionView.numbers = mineArray;
    }
}

@end

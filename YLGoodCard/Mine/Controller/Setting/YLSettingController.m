//
//  YLSettingController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSettingController.h"
#import "YLCondition.h"
#import "YLAboutController.h"
#import "YLTabBarController.h"
#import "YLNavigationController.h"
#import "YLMineController.h"

#import "YLAccountTool.h"
#import "YLAccount.h"

@interface YLSettingController ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *detailTitles;

@end

@implementation YLSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    
    self.titles = @[@"清除缓存", @"关于优卡", @"用户隐私条款"];
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *versionNum = [info objectForKey:@"CFBundleShortVersionString"];
    NSString *appName = [info objectForKey:@"CFBundleName"];
    NSLog(@"当前版本号：%@--%@", versionNum, appName);
    
    self.detailTitles = @[@"126.5M", versionNum, appName];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 200)];
    YLCondition *logOut = [[YLCondition alloc] initWithFrame:CGRectMake(YLLeftMargin, 30, YLScreenWidth - 2 * YLLeftMargin, 40)];
    logOut.type = YLConditionTypeWhite;
    [logOut setTitle:@"退出登录" forState:UIControlStateNormal];
    [footerView addSubview:logOut];
    [logOut addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = footerView;
    
    YLAccount *account = [YLAccountTool account];
    if (account) {
        footerView.hidden = NO;
    } else {
        footerView.hidden = YES;
    }
}

- (void)logout {
    
    NSLog(@"退出登录");
    [YLAccountTool loginOut];
//    // 跳转m到买车控制器
    YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    YLNavigationController *nav = tab.viewControllers[3];
    YLMineController *mine = nav.viewControllers.firstObject;
    mine.isLogin = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"YLSettingController";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = self.titles[indexPath.row];
    cell.detailTextLabel.text = self.detailTitles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        YLAboutController *about = [[YLAboutController alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    }
}

@end

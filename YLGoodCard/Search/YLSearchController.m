//
//  YLSearchController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSearchController.h"
#import "YLSearchBar.h"
#import "YLBuyController.h"
#import "YLSearchView.h"
#import "YLTabBarController.h"
#import "YLNavigationController.h"
#import "YLHomeTool.h"
#import "YLBuyConditionModel.h"

/**
 搜索界面思路:本地
 1、如果通过首页或者其他界面跳转过来的，将传过来的条件更新到搜索框里，点击搜索按钮，保存条件到文件的第一条
 2、点击搜索框跳转的，在搜索框输入的条件，点击搜索按钮保存到文件里
 历史记录：课通过本地文件获取数据
 */

@interface YLSearchController () <UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *searchHistory;// l历史搜索

@property (nonatomic, strong) YLSearchBar *searchBar;
@property (nonatomic, strong) YLSearchView *searchView;

@end

@implementation YLSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTitleBar];
    [self.view addSubview:self.searchView];
}

- (YLSearchView *)searchView {
    
//    // 获取tabBarVC里的导航控制器存放的子控制器，传值到子控制器，再切换视图
//    YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    YLNavigationController *nav2 = tab.viewControllers[1];
//    YLBuyController *buy = nav2.viewControllers.firstObject;
//    tab.selectedIndex = 1;
    
    if (!_searchView) {
        CGRect rect = CGRectMake(0, 0, YLScreenWidth, YLScreenHeight - 64);
        self.searchView = [[YLSearchView alloc] initWithFrame:rect historyArray:self.searchHistory hotArray:self.hotSearch];
//        self.searchView.hotArray = self.hotSearch;
        __weak typeof(self) weakSelf = self;
        self.searchView.tapClick = ^(NSString * _Nonnull string) {
            NSLog(@"%@", string);
            [weakSelf saveSearchHistory:string];
            // 这里跳转到买车控制器
            YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
            model.title = string;
            model.detail = string;
            model.param = string;
            model.key = @"brand";
            
//            NSMutableDictionary *param = [NSMutableDictionary dictionary];
//            [param setValue:string forKey:@"brand"];
//            NSMutableDictionary *tempParam = [NSMutableDictionary dictionary];
//            [tempParam setValue:string forKey:@"brand"];
            // 获取tabBarVC里的导航控制器存放的子控制器，传值到子控制器，再切换视图
            YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            YLNavigationController *nav2 = tab.viewControllers[1];
            YLBuyController *buy = nav2.viewControllers.firstObject;
            buy.paramModel = model;
//            buy.param = param;
//            buy.tempParam = tempParam;
            tab.selectedIndex = 1;
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
    }
    return _searchView;
}

- (void)setHotSearch:(NSMutableArray *)hotSearch {
    
    _hotSearch = hotSearch;
}

- (NSMutableArray *)searchHistory {
    
    if (!_searchHistory) {
        _searchHistory = [NSKeyedUnarchiver unarchiveObjectWithFile:YLSearchHistoryPath];
        if (!_searchHistory) {
            _searchHistory = [NSMutableArray array];
        }
    }
    return _searchHistory;
}

- (YLSearchBar *)searchBar {
    
    if (!_searchBar) {
        _searchBar = [[YLSearchBar alloc] init];
    }
    return _searchBar;
}

/**-------------------------------------------------------------*/
#pragma mark 私有方法
- (void)setTitleBar {

    YLSearchBar *searchBar = [YLSearchBar searchBar];
    searchBar.width = 240;
    searchBar.height = 36;
    searchBar.placeholder = @"请搜索您想要的车";
    searchBar.backgroundColor = YLColor(239.f, 242.f, 247.f);;
    [searchBar setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;

    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = rightBar;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

#pragma mark 私有方法
// 点击搜索
- (void)search {

    // 如果点击是搜索，就以title搜索为主
    if (![self isBlankString:self.searchBar.text]) {
        // 将搜索的条件以字典的形式传给控制器
        NSString *titleString = self.searchBar.text;
        YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
        model.title = titleString;
        model.detail = titleString;
        model.param = titleString;
        model.key = @"title";
        // 跳转m到买车控制器
        YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        YLNavigationController *nav = tab.viewControllers[1];
        YLBuyController *buy = nav.viewControllers.firstObject;
        buy.paramModel = model;
        [buy.titleBar setTitle:titleString forState:UIControlStateNormal];
        tab.selectedIndex = 1;
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        // 保存搜索记录
        [self saveSearchHistory:titleString];
    } else {
        NSLog(@"搜索栏为空");
        [self showMessage:@"搜索栏为空"];
    }
}

// 保存历史搜索记录
- (void)saveSearchHistory:(NSString *)search {
    
    // 获取本地存储的搜索记录:只保留6条
    // 判断输入的条件是否与之前的相同，如果相同，则删除数组中的再插入到数组的第一位
    // 判断数组是否已有记录，有则移除再添加
    if ([self.searchHistory containsObject:search]) {
        NSInteger index = [self.searchHistory indexOfObject:search];
        [self.searchHistory removeObjectAtIndex:index];
    }
    [self.searchHistory insertObject:search atIndex:0];
    if (self.searchHistory.count > 6) {
        [self.searchHistory removeLastObject];
    }
    NSLog(@"%@", YLSearchHistoryPath);
    BOOL success = [NSKeyedArchiver archiveRootObject:self.searchHistory toFile:YLSearchHistoryPath];
    if (success) {
        NSLog(@"保存成功");
    }
    // 清空搜索框
    self.searchBar.text = @"";
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

@end

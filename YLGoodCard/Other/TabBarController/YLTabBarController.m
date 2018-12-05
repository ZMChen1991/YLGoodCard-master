//
//  YLTabBarController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLTabBarController.h"
#import "YLNavigationController.h"
#import "YLMainController.h"
#import "YLBuyController.h"
#import "YLSaleViewController.h"
#import "YLMineController.h"

#import "YLRequest.h"
#import "YLBannerModel.h"
#import "YLNotableModel.h"

@interface YLTabBarController ()

//@property (nonatomic, strong) NSMutableArray *banners;// 轮播图数组
//@property (nonatomic, strong) NSMutableArray *notables;// 成交记录数组

@end

@implementation YLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self loadData];
    
    YLMainController *mainVc = [[YLMainController alloc] init];
//    mainVc.images = self.banners;
//    mainVc.notableTitles = self.notables;
    [self addChildViewController:mainVc title:@"首页" image:@"首页点击" selectImage:nil];
    
    YLBuyController *buyVc = [[YLBuyController alloc] init];
    [self addChildViewController:buyVc title:@"买车" image:@"买车" selectImage:nil];
    
    YLSaleViewController *saleVc = [[YLSaleViewController alloc] init];
    [self addChildViewController:saleVc title:@"卖车" image:@"卖车" selectImage:nil];
    
    YLMineController *mineVc = [[YLMineController alloc] init];
    [self addChildViewController:mineVc title:@"我的" image:@"我的" selectImage:nil];
}

//- (void)loadData {
//    
//    // 获取轮播图
//    NSString *bannerStr = @"http://ucarjava.bceapp.com/home?method=slide";
//    [YLRequest GET:bannerStr parameters:nil success:^(id  _Nonnull responseObject) {
//        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
//            NSLog(@"bannerStr%@", responseObject[@"message"]);
//        } else {
//            NSLog(@"bannerStr%@", responseObject[@"data"]);
//            NSArray *banners = [YLBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//            for (YLBannerModel *model in banners) {
//                [self.banners addObject:model.img];
//            }
//            NSLog(@"%@", self.banners);
//        }
//    } failed:nil];
//    
//    // 获取成交记录
//    NSString *notableStr = @"http://ucarjava.bceapp.com/trade?method=random";
//    [YLRequest GET:notableStr parameters:nil success:^(id  _Nonnull responseObject) {
//        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
//            NSLog(@"notableStr%@", responseObject[@"message"]);
//        } else {
//            NSLog(@"notableStr%@", responseObject[@"data"]);
//            NSArray *notables = [YLNotableModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//            for (YLNotableModel *model in notables) {
//                [self.notables addObject:model.text];
//            }
//            NSLog(@"%@", self.notables);
//        }
//    } failed:nil];
//}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:image];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    YLNavigationController *nav = [[YLNavigationController alloc] initWithRootViewController:childController];
//    NSLog(@"nav:%@--childController:%@", nav, childController);
    // 在此修改tabBarItem的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = YLColor(21.f, 126.f, 251.f);
    [nav.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
    
}

//- (NSMutableArray *)banners {
//
//    if (!_banners) {
//        _banners = [NSMutableArray array];
//    }
//    return  _banners;
//}
//
//- (NSMutableArray *)notables {
//
//    if (!_notables) {
//        _notables = [NSMutableArray array];
//    }
//    return  _notables;
//}
@end

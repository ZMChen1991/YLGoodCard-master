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
    
    YLMainController *mainVc = [[YLMainController alloc] init];
//    mainVc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
    [self addChildViewController:mainVc title:@"首页" image:@"首页点击" selectImage:nil];
    
    YLBuyController *buyVc = [[YLBuyController alloc] init];
//    buyVc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
    [self addChildViewController:buyVc title:@"买车" image:@"买车" selectImage:nil];
    
    YLSaleViewController *saleVc = [[YLSaleViewController alloc] init];
//    saleVc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
    [self addChildViewController:saleVc title:@"卖车" image:@"卖车" selectImage:nil];
    
    YLMineController *mineVc = [[YLMineController alloc] init];
//    mineVc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
    [self addChildViewController:mineVc title:@"我的" image:@"我的" selectImage:nil];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:image];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
    
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

@end

//
//  YLNavigationController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLNavigationController.h"
#import "YLBackButton.h"

@interface YLNavigationController ()

@end

@implementation YLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;

        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, 30, 20);
        [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateHighlighted];
        [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        UIBarButtonItem *nagetiveSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        nagetiveSpace.width = -30;
        viewController.navigationItem.leftBarButtonItems = @[nagetiveSpace, leftBarButtonItem];
        
//        YLBackButton *back = [[YLBackButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
////        back.backgroundColor = [UIColor redColor];
//        back.icon = @"返回";
//        back.backBlock = ^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLEVIEW" object:nil];
//            // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
//            [self popViewControllerAnimated:YES];
//        };
//        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:back];
//        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//        self.navigationItem.leftBarButtonItem = leftBtn;
        
        
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"返回" highImage:@""];
//
//        // 设置右边的更多按钮
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLEVIEW" object:nil];
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

@end

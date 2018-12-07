//
//  YLSaleViewController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

/**
 1、提交卖车x申请的个数
 2、预约卖车
 */

#import "YLSaleViewController.h"
#import "YLSaleView.h"
#import "YLOrderController.h"
#import "YLAccount.h"
#import "YLAccountTool.h"
#import "YLLoginController.h"

@interface YLSaleViewController () <YLConditionDelegate>

@property (nonatomic, strong) YLSaleView *saleView;

@end

@implementation YLSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    
    YLAccount *account = [YLAccountTool account];
    YLSaleView *saleView = [[YLSaleView alloc] init];
    if (account) {
        saleView.telephone = account.telephone;
    }
    saleView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:saleView];
    self.saleView = saleView;
    
    saleView.saleBtn.delegate = self;
    saleView.consultBtn.delegate = self;
    saleView.appraiseBtn.delegate = self;
    
    [self addNotification];
}

- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView) name:@"REFRESHVIEW" object:nil];
}

- (void)refreshView {
    YLAccount *account = [YLAccountTool account];
    self.saleView.telephone = account.telephone;
}

- (void)setupNav {
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"卖车进度" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
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
    
    NSLog(@"按钮被点击了...");

}

#pragma mark YLSaleButton代理方法
- (void)pushController:(UIButton *)sender {
    
    NSLog(@"%@---%ld", sender.titleLabel.text, sender.tag);
    NSString *title = sender.titleLabel.text;
    NSInteger index = sender.tag;
    if (index == 301) {
        // 这里判断用户是否登录，如果没有，跳转到登录界面
        YLAccount *account = [YLAccountTool account];
        if (account) {
            
            YLOrderController *orderVc = [[YLOrderController alloc] init];
            orderVc.telephone = account.telephone;
            orderVc.navigationItem.title = title;
            [self.navigationController pushViewController:orderVc animated:YES];
        } else {
            YLLoginController *login = [[YLLoginController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
        }

    }
    if (index == 302) { // 免费咨询
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"联系电话"
//                                                        message:@"4008301282"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"好的"
//                                              otherButtonTitles:@"拨打", nil];
//        [alert show];
        [self test];
        
    }
    if (index == 303) { // 爱车估价
        [self showMessage:@"开发中，敬请期待"];
    }
    
}
- (void)test {
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", @"4008301282"];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self resignFirstResponder];
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

@end

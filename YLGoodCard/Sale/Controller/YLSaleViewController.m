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
#import "YLRequest.h"

@interface YLSaleViewController () <YLConditionDelegate>

@property (nonatomic, strong) YLSaleView *saleView;

@end

@implementation YLSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    [self.view addSubview:self.saleView];
    [self loadData];
    [self addNotification];
    YLAccount *account = [YLAccountTool account];
    if (account) {
        self.saleView.telephone = account.telephone;
    }
}

- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    NSString *urlString = @"http://ucarjava.bceapp.com/home?method=apply";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"apply:%@", responseObject);
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSLog(@"请求成功:%@", responseObject[@"data"]);
            weakSelf.saleView.salerNum = [NSString stringWithFormat:@"%@", [responseObject[@"data"] valueForKey:@"apply"]];
        }
    } failed:nil];
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
    
//    [self.navigationController.navigationBar setBackgroundColor:YLColor(8.f, 169.f, 255.f)];
//    // 设置导航栏背景为空
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 设置导航栏底部线条为空
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    // 修改导航标题
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    // 创建一个假状态栏
//    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, YLScreenWidth, 20)];
//    statusBarView.backgroundColor = YLColor(8.f, 169.f, 255.f);
//    [self.navigationController.navigationBar addSubview:statusBarView];
    
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

- (void)rightBarButtonItemClick {
    
    NSLog(@"按钮被点击了...");

}

#pragma mark YLSaleButton代理方法
- (void)pushController:(UIButton *)sender {
    
//    NSLog(@"sender.titleLabel:%@---%ld", sender.titleLabel.text, sender.tag);
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

- (YLSaleView *)saleView {
    if (!_saleView) {
        _saleView = [[YLSaleView alloc] initWithFrame:CGRectMake(0, -64, YLScreenWidth, YLScreenHeight)];
        _saleView.saleBtn.delegate = self;
        _saleView.consultBtn.delegate = self;
        _saleView.appraiseBtn.delegate = self;
    }
    return _saleView;
}

@end

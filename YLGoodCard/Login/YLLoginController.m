//
//  YLLoginController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLLoginController.h"
#import "YLCondition.h"
#import "YLMessageCodeTool.h"
#import "YLAccount.h"
#import "YLAccountTool.h"
#import "YLMineController.h"

@interface YLLoginController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *verificationCodeBtn;
@property (nonatomic, strong) UITextField *tel;
@property (nonatomic, strong) UITextField *message;

@end

@implementation YLLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"登录";
    
    float width = self.view.frame.size.width - 2 * YLLeftMargin;
    UILabel *attention = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, YLLeftMargin + 64, width, 17)];
    attention.textColor = [UIColor grayColor];
    attention.text = @"无需注册，输入手机号码即可登录";
    attention.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:attention];
    
    UITextField *tel = [[UITextField alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(attention.frame) + 5, width, 40)];
    tel.font = [UIFont systemFontOfSize:14];
    tel.placeholder = @"请输入您的手机号码";
    tel.layer.cornerRadius = 5;
    tel.layer.borderWidth = 0.6;
    tel.layer.borderColor = [UIColor grayColor].CGColor;
    tel.layer.masksToBounds = YES;
    tel.delegate = self;
    [self.view addSubview:tel];
    self.tel = tel;
    
    UIButton *verificationCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    verificationCodeBtn.frame = CGRectMake(width - YLLeftMargin - width / 4, CGRectGetMaxY(attention.frame) + 5, width / 3, 40);
    [verificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    verificationCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [verificationCodeBtn setTitleColor:YLColor(8.f, 169.f, 255.f) forState:UIControlStateNormal];
    [verificationCodeBtn addTarget:self action:@selector(verificationCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:verificationCodeBtn];
    self.verificationCodeBtn = verificationCodeBtn;
    
    UITextField *message = [[UITextField alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(tel.frame) + YLTopMargin, width, 40)];
    message.font = [UIFont systemFontOfSize:14];
    message.placeholder = @"请输入您的短信验证码";
    message.layer.cornerRadius = 5;
    message.layer.borderWidth = 0.6;
    message.layer.borderColor = [UIColor grayColor].CGColor;
    message.layer.masksToBounds = YES;
    message.delegate = self;
    [self.view addSubview:message];
    self.message = message;

    YLCondition *loginBtn = [[YLCondition alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(message.frame) + YLTopMargin, width, 40)];
    loginBtn.type = YLConditionTypeBlue;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin,  CGRectGetMaxY(loginBtn.frame) + YLTopMargin, width, 17)];
    NSString *str = @"登录即视为同意《用户使用协议》及《隐私权条款》";
    NSAttributedString *str1 = [str changeString:@"《用户使用协议》及《隐私权条款》" color:YLColor(8.f, 169.f, 255.f)];
    text.attributedText = str1;
    text.font = [UIFont systemFontOfSize:12];
    text.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:text];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.tel resignFirstResponder];
    [self.message resignFirstResponder];
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    [self.tel becomeFirstResponder];
//    [self.message becomeFirstResponder];
//    return YES;
//}

//获取验证码
- (void)verificationCode {
    
    if([NSString isBlankString:self.tel.text]) {
        
        NSLog(@"请输入电话号码");
        [self showMessage:@"请输入电话号码"];
    } else {
        [self timeDown];
        // 获取短信验证码
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"telephone"] = self.tel.text;
        [YLMessageCodeTool messageCodeWithParam:param success:^(NSDictionary * _Nonnull result) {
            NSLog(@"验证码发送成功");
            [self showMessage:@"验证码发送成功"];
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"验证码发送失败");
            [self showMessage:@"验证码发送失败"];
        }];
    }
}
// 验证码倒计时
- (void)timeDown {
    
    /****************倒计时****************/
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [self.verificationCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.verificationCodeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                self.verificationCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [self.verificationCodeBtn setTitle:[NSString stringWithFormat:@"%.2d重发", seconds] forState:UIControlStateNormal];
                [self.verificationCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                self.verificationCodeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)login {
    
    [self.tel resignFirstResponder];
    [self.message resignFirstResponder];
    
    if ([NSString isBlankString:self.tel.text] || [NSString isBlankString:self.message.text]) {
        [self showMessage:@"请输入电话号码或验证码"];
    } else {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"telephone"] = self.tel.text;
        param[@"code"] = self.message.text;
        [YLMessageCodeTool loginWithParam:param success:^(NSDictionary * _Nonnull result) {
            if ([result[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
                NSString *message = result[@"message"];
                [self showMessage:message];
            }
            if ([result[@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                NSLog(@"登录成功:%@", result[@"message"]);
                // 返回账号字典数据-->模型，存进沙盒
                YLAccount *account = [YLAccount accountWithDict:result[@"data"]];
                // 存储账号信息
                [YLAccountTool saveAccount:account];
                // 返回我的窗口
                if (self.loginBlock) {
                    self.loginBlock(@"登录成功");
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError * _Nonnull error) {
        }];
    }
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


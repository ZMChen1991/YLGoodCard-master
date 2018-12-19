//
//  YLSuggestionController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSuggestionController.h"
#import "YLCondition.h"
#import "YLAccountTool.h"
#import "YLAccount.h"
#import "YLRequest.h"

@interface YLSuggestionController ()

@property (nonatomic, strong) UITextView *suggestion;
@property (nonatomic, strong) UITextField *telephone;

@end

@implementation YLSuggestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    YLAccount *account = [YLAccountTool account];
    
    NSInteger width = YLScreenWidth - 2 * YLLeftMargin;
    UITextView *suggestion = [[UITextView alloc] initWithFrame:CGRectMake(YLLeftMargin, YLLeftMargin + 64, width, 130)];
    suggestion.layer.cornerRadius = 5;
    suggestion.layer.borderWidth = 0.6;
    suggestion.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    suggestion.layer.masksToBounds = YES;
    suggestion.font = [UIFont systemFontOfSize:14];
    [suggestion setPlaceholder:@"请输入您的意见或者建议..." placeholdColor:[UIColor grayColor]];
    [self.view addSubview:suggestion];
    self.suggestion = suggestion;
    
    UITextField *telephone = [[UITextField alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(suggestion.frame) + YLTopMargin, width, 50)];
    telephone.layer.cornerRadius = 5;
    telephone.layer.borderWidth = 0.6;
    telephone.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    telephone.layer.masksToBounds = YES;
    telephone.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:telephone];
    self.telephone = telephone;
    if (account) {
        telephone.text = account.telephone;
    } else {
        telephone.placeholder = @"  联系方式（选填）";
    }
    
    YLCondition *commitBtn = [[YLCondition alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(telephone.frame) + YLTopMargin, width, 40)];
    commitBtn.type = YLConditionTypeBlue;
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
}

- (void)commit {
    
    NSLog(@"提交意见反馈");
    [self postSuggestion];
}

- (void)postSuggestion {
    // 提交意见反馈
    NSString *urlString = @"http://ucarjava.bceapp.com/opinion?method=add";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.telephone.text forKey:@"telephone"];
    [param setValue:self.suggestion.text forKey:@"remarks"];
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSLog(@"提交成功!");
            [self showMessage:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"提交失败!");
        }
    } failed:nil];
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

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

@interface YLSuggestionController ()

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
    suggestion.layer.borderColor = [UIColor grayColor].CGColor;
    suggestion.layer.masksToBounds = YES;
    suggestion.font = [UIFont systemFontOfSize:14];
    [suggestion setPlaceholder:@"请输入您的意见或者建议..." placeholdColor:[UIColor grayColor]];
    [self.view addSubview:suggestion];
    
    UITextField *telephone = [[UITextField alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(suggestion.frame) + YLTopMargin, width, 50)];
    telephone.layer.cornerRadius = 5;
    telephone.layer.borderWidth = 0.6;
    telephone.layer.borderColor = [UIColor grayColor].CGColor;
    telephone.layer.masksToBounds = YES;
    telephone.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:telephone];
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
}

@end

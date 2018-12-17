//
//  YLComplaintController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLComplaintController.h"
#import "YLTableGroupHeader.h"
#import "YLCondition.h"
#import "YLRequest.h"
#import "YLDetectCenterController.h"
#import "YLAccount.h"
#import "YLAccountTool.h"

@interface YLComplaintController () <UITextViewDelegate>

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;
@property (nonatomic, strong) UIButton *niming;
@property (nonatomic, strong) UIButton *choiceBtn;

@property (nonatomic, strong) UITextView *text;
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) NSString *centerId;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) NSString *reason1;
@property (nonatomic, strong) NSString *reason2;
@property (nonatomic, strong) NSString *reason3;
@property (nonatomic, strong) NSString *reason4;

@property (nonatomic, assign) BOOL isSelect1;
@property (nonatomic, assign) BOOL isSelect2;
@property (nonatomic, assign) BOOL isSelect3;
@property (nonatomic, assign) BOOL isSelect4;
@property (nonatomic, assign) BOOL isNiming;


@end

@implementation YLComplaintController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"投诉";
    self.isNiming = NO;
    self.isSelect1 = NO;
    self.isSelect2 = NO;
    self.isSelect3 = NO;
    self.isSelect4 = NO;
    
    UILabel *choiceCenter = [[UILabel alloc] init];
    choiceCenter.frame = CGRectMake(YLLeftMargin, 12 + 64, 112, 20);
    choiceCenter.font = [UIFont systemFontOfSize:14];
    choiceCenter.text = @"选择检测中心";
    [self.view addSubview:choiceCenter];
    
    UIButton *choiceBtn = [[UIButton alloc] init];
    choiceBtn.frame = CGRectMake(YLScreenWidth - YLLeftMargin - 100, 12 + 64, 100, 20);
    choiceBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [choiceBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [choiceBtn setTitleColor:YLColor(155.f, 155.f, 155.f) forState:UIControlStateNormal];
    [choiceBtn addTarget:self action:@selector(choiceCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choiceBtn];
    self.choiceBtn = choiceBtn;
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    line.frame = CGRectMake(0, CGRectGetMaxY(choiceCenter.frame) + YLLeftMargin, YLScreenWidth, 1);
    [self.view addSubview:line];
    
    UILabel *question = [[UILabel alloc] init];
    question.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(line.frame) + YLLeftMargin, 84, 20);
    question.font = [UIFont systemFontOfSize:14];
    question.text = @"投诉问题";
    [self.view addSubview:question];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(70, CGRectGetMaxY(question.frame) + 10, 18, 18);
//    btn1.type = YLConditionTypeWhite;
    btn1.layer.borderWidth = 1.f;
    btn1.layer.cornerRadius = 18/2;
    btn1.layer.masksToBounds = YES;
    btn1.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    self.btn1 = btn1;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(CGRectGetMaxX(btn1.frame) + 5, CGRectGetMaxY(question.frame) + 10, 100, 18);
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = YLColor(51.f, 51.f, 51.f);
    label1.text = @"态度傲慢";
    [self.view addSubview:label1];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btn1Click)];
    [label1 addGestureRecognizer:tap1];
    label1.userInteractionEnabled = YES;
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(227, CGRectGetMaxY(question.frame) + 10, 18, 18);
//    btn2.type = YLConditionTypeWhite;
    btn2.layer.borderWidth = 1.f;
    btn2.layer.cornerRadius = 18/2;
    btn2.layer.masksToBounds = YES;
    btn2.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    self.btn2 = btn2;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(CGRectGetMaxX(btn2.frame) + 5, CGRectGetMaxY(question.frame) + 10, 100, 18);
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = YLColor(51.f, 51.f, 51.f);
    label2.text = @"技术不专业";
    [self.view addSubview:label2];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btn2Click)];
    [label2 addGestureRecognizer:tap2];
    label2.userInteractionEnabled = YES;
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(70, CGRectGetMaxY(btn1.frame) + YLLeftMargin, 18, 18);
//    btn3.type = YLConditionTypeWhite;
    btn3.layer.borderWidth = 1.f;
    btn3.layer.cornerRadius = 18/2;
    btn3.layer.masksToBounds = YES;
    btn3.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    [btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    self.btn3 = btn3;
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.frame = CGRectMake(CGRectGetMaxX(btn3.frame) + 5, CGRectGetMaxY(btn1.frame) + YLLeftMargin, 100, 18);
    label3.font = [UIFont systemFontOfSize:14];
    label3.textColor = YLColor(51.f, 51.f, 51.f);
    label3.text = @"检测不严谨";
    [self.view addSubview:label3];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btn3Click)];
    [label3 addGestureRecognizer:tap3];
    label3.userInteractionEnabled = YES;
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(227, CGRectGetMaxY(btn2.frame) + YLLeftMargin, 18, 18);
//    btn4.type = YLConditionTypeWhite;
    btn4.layer.borderWidth = 1.f;
    btn4.layer.cornerRadius = 18/2;
    btn4.layer.masksToBounds = YES;
    btn4.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    [btn4 addTarget:self action:@selector(btn4Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    self.btn4 = btn4;
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.frame = CGRectMake(CGRectGetMaxX(btn4.frame) + 5, CGRectGetMaxY(btn2.frame) + YLLeftMargin, 100, 18);
    label4.font = [UIFont systemFontOfSize:14];
    label4.textColor = YLColor(51.f, 51.f, 51.f);
    label4.text = @"店铺环境差";
    [self.view addSubview:label4];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btn4Click)];
    [label4 addGestureRecognizer:tap4];
    label4.userInteractionEnabled = YES;
    
    UILabel *otherQuestion = [[UILabel alloc] init];
    otherQuestion.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(btn3.frame) + 20, 112, 20);
    otherQuestion.font = [UIFont systemFontOfSize:14];
    otherQuestion.text = @"其他问题(选填)";
    [self.view addSubview:otherQuestion];
    
    UITextView *text = [[UITextView alloc] init];
    text.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(otherQuestion.frame) + 5, YLScreenWidth - 2 * YLLeftMargin, 101);
    text.layer.borderWidth = 1.f;
    text.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    text.delegate = self;
//    text.textColor = YLColor(233.f, 233.f, 233.f);
    [self.view addSubview:text];
    self.text = text;
    
    UILabel *imageLabel = [[UILabel alloc] init];
    imageLabel.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(text.frame) + YLLeftMargin, 112, 20);
    imageLabel.font = [UIFont systemFontOfSize:14];
    imageLabel.text = @"图片(选填)";
    [self.view addSubview:imageLabel];
    
    CGFloat btnX = 0;
    CGFloat btnY = CGRectGetMaxY(imageLabel.frame) + 5;
    CGFloat btnW = 110;
    CGFloat btnH = 80;
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX * i + YLLeftMargin, btnY, btnW, btnH);
        btn.backgroundColor = YLColor(233.f, 233.f, 233.f);
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btnX = btnW + 8;
        [self.imageViews addObject:btn];
    }
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(imageLabel.frame) + 140, 18, 18);
//    btn5.type = YLConditionTypeWhite;
    btn5.layer.borderWidth = 1.f;
    btn5.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    btn5.layer.cornerRadius = 18/2;
    btn5.layer.masksToBounds = YES;
    [btn5 addTarget:self action:@selector(btn5Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    self.niming = btn5;
    
    UILabel *niming = [[UILabel alloc] init];
    niming.frame = CGRectMake(CGRectGetMaxX(btn5.frame) + 5, CGRectGetMaxY(imageLabel.frame) + 140, 112, 18);
    niming.font = [UIFont systemFontOfSize:14];
    niming.text = @"匿名提交";
    [self.view addSubview:niming];
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btn5Click)];
    [niming addGestureRecognizer:tap5];
    niming.userInteractionEnabled = YES;
    
    YLCondition *commit = [YLCondition buttonWithType:UIButtonTypeCustom];
    commit.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(btn5.frame) + 20, YLScreenWidth - 2 * YLLeftMargin, 40);
    commit.type = YLConditionTypeBlue;
    [commit setTitle:@"提交" forState:UIControlStateNormal];
    [commit addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commit];
}

- (void)imageBtnClick:(UIButton *)sender {
    NSInteger tag = sender.tag - 100;
    NSLog(@"点击了第%ld个图片按钮", tag);
    
}

- (void)btn1Click {
    NSLog(@"1");
    self.isSelect1 = !self.isSelect1;
    if (self.isSelect1) {
//        self.btn1.type = YLConditionTypeBlue;
        [self.btn1 setImage:[UIImage imageNamed:@"安全"] forState:UIControlStateNormal];
        self.reason1 = [NSString stringWithFormat:@"attitude"];
    } else {
//        self.btn1.type = YLConditionTypeWhite;
        [self.btn1 setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        self.reason1 = @"";
    }
}
- (void)btn2Click {
    NSLog(@"2");
    self.isSelect2 = !self.isSelect2;
    if (self.isSelect2) {
//        self.btn2.type = YLConditionTypeBlue;
        [self.btn2 setImage:[UIImage imageNamed:@"安全"] forState:UIControlStateNormal];
        self.reason2 = [NSString stringWithFormat:@"technique"];
    } else {
//        self.btn2.type = YLConditionTypeWhite;
        [self.btn2 setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        self.reason2 = @"";
    }
}
- (void)btn3Click {
    NSLog(@"3");
    self.isSelect3 = !self.isSelect3;
    if (self.isSelect3) {
//        self.btn3.type = YLConditionTypeBlue;
        [self.btn3 setImage:[UIImage imageNamed:@"安全"] forState:UIControlStateNormal];
        self.reason3 = [NSString stringWithFormat:@"detection"];
    } else {
//        self.btn3.type = YLConditionTypeWhite;
        [self.btn3 setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        self.reason3 = @"";
    }
}
- (void)btn4Click {
    NSLog(@"4");
    self.isSelect4 = !self.isSelect4;
    if (self.isSelect4) {
//        self.btn4.type = YLConditionTypeBlue;
        [self.btn4 setImage:[UIImage imageNamed:@"安全"] forState:UIControlStateNormal];
        self.reason4 = [NSString stringWithFormat:@"environment"];
    } else {
//        self.btn4.type = YLConditionTypeWhite;
        [self.btn4 setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        self.reason4 = @"";
    }
}
- (void)btn5Click {
    NSLog(@"5");
    self.isNiming = !self.isNiming;
    if (self.isNiming) {
//        self.niming.type = YLConditionTypeBlue;
        [self.niming setImage:[UIImage imageNamed:@"安全"] forState:UIControlStateNormal];
    } else {
//        self.niming.type = YLConditionTypeWhite;
        [self.niming setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    }
}

- (void)choiceCenter {
    
    YLDetectCenterController *center = [[YLDetectCenterController alloc] init];
    center.city = @"阳江";
    center.detectCenterBlock = ^(YLDetectCenterModel * _Nonnull model) {
        NSLog(@"%@", model.ID);
        self.centerId = model.ID;
        [self.choiceBtn setTitle:model.name forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:center animated:YES];
}


- (void)commitClick {
    NSLog(@"投诉提交");
    self.reason = [NSString stringWithFormat:@"%@;%@;%@;%@", self.reason1, self.reason2, self.reason3, self.reason4];
    YLAccount *account = [YLAccountTool account];
    NSString *urlString = @"http://ucarjava.bceapp.com/complaint?method=add";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.centerId forKey:@"centerId"];
    [param setValue:self.reason forKey:@"reason"];
    [param setValue:self.text.text forKey:@"remarks"];
    [param setValue:[NSString stringWithFormat:@"%d", self.isNiming] forKey:@"isAnonymity"];
    if (!self.isNiming) {
        [param setValue:account.telephone forKey:@"telephone"];
    }
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSLog(@"发送成功");
            [self showMessage:@"发送成功"];
        } else {
            NSLog(@"发送失败:%@", responseObject[@"message"]);
            [self showMessage:@"发送失败"];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.text resignFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    
}

@end

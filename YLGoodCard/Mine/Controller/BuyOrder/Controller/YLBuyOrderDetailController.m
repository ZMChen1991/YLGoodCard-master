//
//  YLBuyOrderDetailController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBuyOrderDetailController.h"
#import "YLBuyOrderCommand.h"
#import "YLContactView.h"
#import "YLCompleteView.h"
#import "YLStepView.h"
#import "YLRequest.h"
#import "YLDetailController.h"

@interface YLBuyOrderDetailController ()

@property (nonatomic, strong) YLStepView *stepView;
@property (nonatomic, strong) YLContactView *contactView;
@property (nonatomic, strong) YLCompleteView *completeView;

@end

@implementation YLBuyOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"买车订单";
    
    
}

//- (void)loadData {
//
//    NSString *urlString = @"";
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//
//}

- (void)createUI {
    
    YLBuyOrderCommand *command = [[YLBuyOrderCommand alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 110)];
    command.model = self.model;
    __weak typeof(self) weakSelf = self;
    command.buyOrderCommandBlock = ^(YLTableViewModel * _Nonnull model) {
        YLDetailController *detai = [[YLDetailController alloc] init];
        detai.model = model;
        [weakSelf.navigationController pushViewController:detai animated:YES];
    };
    [self.view addSubview:command];
    
    NSArray *titles = @[@"合同签署", @"车辆复检", @"交易完成"];
    YLStepView *stepView = [[YLStepView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(command.frame) + YLLeftMargin, YLScreenWidth, 80) titles:titles];
//    stepView.stepIndex = 1;
    [self.view addSubview:stepView];
    self.stepView = stepView;
    
    YLContactView *contactView = [[YLContactView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(stepView.frame) + YLLeftMargin, YLScreenWidth, 110)];
    contactView.hidden = YES;
    contactView.contactBlock = ^{
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", @"4008301282"];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
    };
    [self.view addSubview:contactView];
    self.contactView = contactView;
    
    YLCompleteView *completeView = [[YLCompleteView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(stepView.frame) + YLLeftMargin, YLScreenWidth, 110)];
    completeView.hidden = YES;
    completeView.completeBlock = ^{
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", @"4008301282"];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
    };
    [self.view addSubview:completeView];
    self.completeView = completeView;
}


- (void)setModel:(YLBuyOrderModel *)model {
    _model = model;
    
    [self createUI];

    if ([model.status isEqualToString:@"3"]) { // 已签合同
        self.stepView.stepIndex = 0;
        self.contactView.hidden = NO;
        self.contactView.message = @"合同已签署，正在等待复检过户...";
        self.completeView.hidden = YES;
    } else if ([model.status isEqualToString:@"4"]) {// 复检过户
        self.stepView.stepIndex = 1;
        self.contactView.hidden = NO;
        self.contactView.message = @"车辆已复检，即将进行过户手续...";
        self.completeView.hidden = YES;
    } else if ([model.status isEqualToString:@"5"]) {// 交易完成
        self.stepView.stepIndex = 2;
        self.contactView.hidden = YES;
        self.completeView.hidden = NO;
    }
}

@end

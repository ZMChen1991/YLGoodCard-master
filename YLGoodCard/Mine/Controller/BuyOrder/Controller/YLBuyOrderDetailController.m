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

- (void)createUI {
    
    YLBuyOrderCommand *command = [[YLBuyOrderCommand alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, 110)];
    command.model = self.model;
    [self.view addSubview:command];
    
    NSArray *titles = @[@"合同签署", @"复检过户", @"交易完成"];
    YLStepView *stepView = [[YLStepView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(command.frame), YLScreenWidth, 90) titles:titles];
    stepView.stepIndex = 1;
    [self.view addSubview:stepView];
    self.stepView = stepView;
    
    YLContactView *contactView = [[YLContactView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(stepView.frame), YLScreenWidth, 110)];
    contactView.hidden = YES;
    [self.view addSubview:contactView];
    self.contactView = contactView;
    
    YLCompleteView *completeView = [[YLCompleteView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(stepView.frame) + YLLeftMargin, YLScreenWidth, 110)];
    completeView.hidden = YES;
    [self.view addSubview:completeView];
    self.completeView = completeView;
}

- (void)setModel:(YLBuyOrderModel *)model {
    _model = model;
    
    [self createUI];
    
    model.status = @"5";
    
    if ([model.status isEqualToString:@"3"]) { // 已签合同
        self.stepView.stepIndex = 0;
        self.contactView.hidden = NO;
    } else if ([model.status isEqualToString:@"4"]) {// 复检过户
        self.stepView.stepIndex = 1;
        self.contactView.hidden = NO;
    } else if ([model.status isEqualToString:@"5"]) {// 交易完成
        self.stepView.stepIndex = 2;
        self.contactView.hidden = YES;
        self.completeView.hidden = NO;
    }
}

@end

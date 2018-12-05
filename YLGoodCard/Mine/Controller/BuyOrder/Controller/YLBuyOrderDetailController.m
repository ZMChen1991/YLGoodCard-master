//
//  YLBuyOrderDetailController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBuyOrderDetailController.h"
#import "YLCommandView.h"
#import "YLContactView.h"
#import "YLCompleteView.h"
#import "YLStepView.h"

@interface YLBuyOrderDetailController ()

@end

@implementation YLBuyOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"买车订单";
    
    YLCommandView *command = [[YLCommandView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, 110)];
    [self.view addSubview:command];
    
    NSArray *titles = @[@"合同签署", @"复检过户", @"交易完成"];
    YLStepView *stepView = [[YLStepView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(command.frame), YLScreenWidth, 90) titles:titles];
    stepView.stepIndex = 1;
    [self.view addSubview:stepView];
    
    YLContactView *contactView = [[YLContactView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(stepView.frame), YLScreenWidth, 110)];
    [self.view addSubview:contactView];
    
    YLCompleteView *completeView = [[YLCompleteView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contactView.frame) + YLLeftMargin, YLScreenWidth, 110)];
    [self.view addSubview:completeView];
}


@end

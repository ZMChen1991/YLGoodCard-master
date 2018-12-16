//
//  YLSaleOrderController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSaleOrderController.h"
#import "YLSubSaleOrderController.h"
#import "YLAccountTool.h"
#import "YLAccount.h"

#import "YLSaleDoneController.h"
#import "YLAllSaleOrderController.h"
#import "YLSellingController.h"
#import "YLSoldOutController.h"
#import "YLStayOnController.h"

@interface YLSaleOrderController ()

@property (nonatomic, strong) YLSubSaleOrderController *subSaleOrder;

@end

@implementation YLSaleOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.skip.titles = self.titles;
    YLAllSaleOrderController *allSaleOrder = [[YLAllSaleOrderController alloc] init];
    YLStayOnController *stayOn = [[YLStayOnController alloc] init];
    YLSellingController *selling = [[YLSellingController alloc] init];
    YLSaleDoneController *saleDone = [[YLSaleDoneController alloc] init];
    YLSoldOutController *soldOut = [[YLSoldOutController alloc] init];
    
    [self addChildViewController:allSaleOrder];
    [self addChildViewController:stayOn];
    [self addChildViewController:selling];
    [self addChildViewController:saleDone];
    [self addChildViewController:soldOut];
    
    self.skip.controllers = [NSMutableArray arrayWithObjects:allSaleOrder, stayOn, selling, saleDone, soldOut, nil];
    [self.view addSubview:self.skip];
}

- (YLSkipView *)skip {
    
    if (!_skip) {
        _skip = [[YLSkipView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    }
    return _skip;
}

//- (void)setParams:(NSArray *)params {
//    _params = params;
//}

@end

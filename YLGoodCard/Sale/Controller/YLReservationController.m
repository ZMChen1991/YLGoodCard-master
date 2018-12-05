//
//  YLReservationController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
// 预约成功界面

#import "YLReservationController.h"
#import "YLReservationView.h"

@interface YLReservationController ()



@end

@implementation YLReservationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我要卖车";
    
    YLReservationView *reservationView = [[YLReservationView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, YLScreenHeight)];
    reservationView.model = self.detectCenterModel;
    reservationView.checkOut = self.checkOut;
    reservationView.reserVationBlock = ^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    
    [self.view addSubview:reservationView];
}

@end

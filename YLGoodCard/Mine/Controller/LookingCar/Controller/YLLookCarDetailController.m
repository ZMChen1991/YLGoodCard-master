//
//  YLLookCarDetailController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLLookCarDetailController.h"
#import "YLLookCarDetailView.h"
#import "YLAppointView.h"
#import "YLLookCarModel.h"
#import "YLDetectCenterModel.h"
#import "YLRequest.h"
#import "YLDetailController.h"

@interface YLLookCarDetailController ()

@property (nonatomic, strong) YLAppointView *appointView;

@end

@implementation YLLookCarDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"看车详情";

    [self loadData];
    [self setUI];

}

- (void)setUI {
    
    YLLookCarDetailView *command = [[YLLookCarDetailView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, 110)];
    command.model = self.model;
    __weak typeof(self) weakSelf = self;
    command.lookCarDetailBlock = ^(YLTableViewModel * _Nonnull model) {
        YLDetailController *detail = [[YLDetailController alloc] init];
        detail.model = model;
        [weakSelf.navigationController pushViewController:detail animated:YES];
    };
    [self.view addSubview:command];
    
    YLAppointView *appoint = [[YLAppointView alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(command.frame) + 30, YLScreenWidth - 2 * YLLeftMargin, 200)];
    appoint.time = self.model.appointTime;
    [self.view addSubview:appoint];
    self.appointView = appoint;
}


- (void)loadData {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/center?method=id";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.model.centerId forKey:@"id"];
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        YLDetectCenterModel * model = [YLDetectCenterModel mj_objectWithKeyValues:responseObject[@"data"]];
//        NSLog(@"model-%@", model);
        self.appointView.model = model;
    } failed:nil];
}


@end

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
    
    YLLookCarDetailView *command = [[YLLookCarDetailView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 110)];
    command.model = self.model;
    __weak typeof(self) weakSelf = self;
    command.lookCarDetailBlock = ^(YLTableViewModel * _Nonnull model) {
        if([model.status isEqualToString:@"4"] || [model.status isEqualToString:@"0"]) {
            [weakSelf showMessage:@"车辆已下架"];
        } else {
            YLDetailController *detail = [[YLDetailController alloc] init];
            detail.model = model;
            [weakSelf.navigationController pushViewController:detail animated:YES];
        }
    };
    [self.view addSubview:command];
    
    YLAppointView *appoint = [[YLAppointView alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(command.frame) + 30, YLScreenWidth - 2 * YLLeftMargin, 200)];
    appoint.time = self.model.appointTime;
    [self.view addSubview:appoint];
    self.appointView = appoint;
}

// 提示弹窗
- (void)showMessage:(NSString *)message {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;// 获取最上层窗口
    UILabel *messageLabel = [[UILabel alloc] init];
    CGSize messageSize = CGSizeMake([message getSizeWithFont:[UIFont systemFontOfSize:12]].width + 50, 50);
    messageLabel.frame = CGRectMake((YLScreenWidth - messageSize.width) / 2, YLScreenHeight/2, messageSize.width, messageSize.height);
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = YLColor(233.f, 233.f, 233.f);
    messageLabel.layer.cornerRadius = 5.0f;
    messageLabel.layer.masksToBounds = YES;
    [window addSubview:messageLabel];
    [UIView animateWithDuration:2 animations:^{
        messageLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [messageLabel removeFromSuperview];
    }];
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

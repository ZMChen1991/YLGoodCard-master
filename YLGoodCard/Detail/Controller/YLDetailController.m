//
//  YLDetailController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailController.h"
#import "YLDetailFooterView.h"
#import "YLDetailHeaderView.h"
#import "YLSafeguardCell.h"
#import "YLInformationCell.h"
#import "YLCarInformationCell.h"
#import "YLReportCell.h"
#import "YLCondition.h"
#import "YLDetailFooterView.h"
//#import "YLCoverView.h"
#import "YLTableGroupHeader.h"
#import "YLDetailTool.h"
#import "YLDetailModel.h"
#import "YLDetailHeaderModel.h"
#import "YLDetailInfoModel.h"
#import "YLDetailHeaderModel.h"

#import "YLConfigController.h"
#import "YLLoginController.h"

#import "YLAccount.h"
#import "YLAccountTool.h"

#import "YLDetailOrderTimeView.h"
#import "YLDetailBargainView.h"

// 进入详情页，保存当前汽车的ID
// 浏览记录路径
#define YLBrowsingHistoryPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"browsingHistory.plist"]

@interface YLDetailController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *bg;
@property (nonatomic, strong) UIView *labelView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YLDetailHeaderView *header;
@property (nonatomic, strong) YLDetailFooterView *footer;
@property (nonatomic, strong) UIView *cover;
@property (nonatomic, strong) YLDetailBargainView *detailBargain;
@property (nonatomic, strong) YLDetailOrderTimeView *detailOrderTime;

@property (nonatomic, strong) YLDetailModel *detailModel;
@property (nonatomic, strong) NSMutableArray *browsingHistory;

@end

@implementation YLDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self setupNav];
    [self addTableView];
    [self saveBrowseHistory:self.model];
}

- (void)loadData {
    
    YLAccount *account = [YLAccountTool account];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = self.model.carID;
    param[@"telephone"] = account.telephone;
    __weak typeof(self) weakSelf = self;
    // 获取详情车辆数据
    [YLDetailTool detailWithParam:param success:^(YLDetailModel *result) {
        self.detailModel = result;
        YLDetailHeaderModel *headerModel = [YLDetailHeaderModel mj_objectWithKeyValues:weakSelf.detailModel];
        // 给头脚赋值
        weakSelf.header.model = headerModel;
        weakSelf.footer.model = self.detailModel;
        weakSelf.detailBargain.salePrice = self.detailModel.price;
        
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {

    }];
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YLSafeguardCell *cell = [YLSafeguardCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } if (indexPath.section == 1) {
        YLInformationCell *cell = [YLInformationCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 这里赋值给cell
        YLDetailInfoModel *infoModel = [YLDetailInfoModel mj_objectWithKeyValues:self.detailModel];
        if (infoModel) {
            cell.model = infoModel;
        }
        return cell;
    } if (indexPath.section == 2) {
        YLReportCell *cell = [YLReportCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 这里赋值给cell
        
        return cell;
    } else {
        YLCarInformationCell *cell = [YLCarInformationCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 这里赋值给cell
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    CGRect headerRect = CGRectMake(0, 0, YLScreenWidth, 44);
    NSArray *titles = @[@"服务保障",@"基本信息",@"检测报告",@"车辆图文"];
    NSArray *images = @[@"服务保障", @"基本信息", @"检测报告", @"车辆图文"];
    NSArray *details = @[@"", @"查看更多配置", @"", @""];
    YLTableGroupHeader *header = [[YLTableGroupHeader alloc] initWithFrame:headerRect image:images[section] title:titles[section] detailTitle:details[section] arrowImage:@"更多"];
    header.labelBlock = ^(NSString * _Nonnull string) {
        NSLog(@"string:%@",string);
        BOOL success = [string isEqualToString:@"查看更多配置"];
        NSLog(@"success:%d", success);
        if ([string isEqualToString:@"查看更多配置"]) {
            NSLog(@"跳转更多配置界面");
            [self showMessage:@"正在开发中，敬请期待"];
        }
    };
    header.backgroundColor = [UIColor whiteColor];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 1.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 160 + YLLeftMargin;
    }
    if (indexPath.section == 1) {
        return 211;
    }
    if (indexPath.section == 2) {
        return 473 + 1;
    } else {
        return 230;
    }
}

#pragma mark 添加视图
- (void)addTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight - 60) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    YLDetailHeaderView *header = [[YLDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 365)];
    header.detailHeaderBargainBlock = ^{
        NSLog(@"点击了砍价,弹出砍价视图");
        [self bargainClick];
    };
    self.header = header;
    self.tableView.tableHeaderView = header;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    YLAccount *account = [YLAccountTool account];
    __weak typeof(self) weakSelf = self;
    YLDetailFooterView *footer = [[YLDetailFooterView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 60, YLScreenWidth, 60)];
    footer.collectBlock = ^(BOOL isCollect) {
        if (account) {
            if (isCollect) {
                // 点击收藏，向后台发送收藏请求
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"1" forKey:@"status"];
                [param setValue:weakSelf.model.carID forKey:@"detailId"];
                [param setValue:account.telephone forKey:@"telephone"];
                [YLDetailTool favoriteWithParam:param success:^(NSDictionary *result) {
                    NSLog(@"点击了收藏按钮:%@", result);
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLEVIEW" object:nil];
                } failure:nil];
            } else {
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"0" forKey:@"status"];
                [param setValue:self.model.carID forKey:@"detailId"];
                [param setValue:account.telephone forKey:@"telephone"];
                [YLDetailTool favoriteWithParam:param success:^(NSDictionary *result) {
                    NSLog(@"点击了取消收藏按钮:%@", result);
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLEVIEW" object:nil];
                } failure:nil];
            }
        } else {
            YLLoginController *login = [[YLLoginController alloc] init];
            [weakSelf.navigationController pushViewController:login animated:YES];
        }
    };
    [footer.bargain addTarget:self action:@selector(bargainClick) forControlEvents:UIControlEventTouchUpInside];
    [footer.order addTarget:self action:@selector(orderCarClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:footer];
    self.footer = footer;
    
    [self.view addSubview:self.cover];
    [self.cover addSubview:self.detailBargain];
    [self.cover addSubview:self.detailOrderTime];
}

- (void)setupNav {
    
    self.navigationItem.title = @"详情";
}

#pragma mark 砍价
- (void)bargainClick {
    
    YLAccount *account = [YLAccountTool account];
    // 判断用户是否登录
    if (account) {
        NSLog(@"点击了砍价,弹出砍价视图");
        self.cover.hidden = NO;
        self.detailBargain.hidden = NO;
    } else {
        // 没有登录，跳转登录界面
        YLLoginController *login = [[YLLoginController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }
}

#pragma mark 预约看车
- (void)orderCarClick {
    NSLog(@"点击了预约看车，弹出预约看车视图");
    YLAccount *account = [YLAccountTool account];
    // 判断用户是否登录
    if (account) {
        NSLog(@"点击了预约看车，弹出预约看车视图");
        self.cover.hidden = NO;
        self.detailOrderTime.hidden = NO;
    } else {
        // 没有登录，跳转登录界面
        YLLoginController *login = [[YLLoginController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }
}


#pragma mark 砍价预约看车代理方法
//- (void)bargainPrice {
//    NSLog(@"点击了header的砍价");
//    self.cover.salePrice = self.detailModel.price;
//    __weak typeof(self) weakSelf = self;
//    self.cover.bargainBlock = ^(NSString *price) {
//        NSLog(@"砍价的价格是：%@", price);
//        // 判断用户是否登录
//        if (weakSelf.account) {
//            NSString *bargainPrice = [NSString stringWithFormat:@"%.f", [price floatValue] * 10000];
//            // 向后台发送砍价请求
//            NSMutableDictionary *param = [NSMutableDictionary dictionary];
//            [param setValue:weakSelf.detailModel.telephone forKey:@"seller"];
//            [param setValue:weakSelf.account.telephone forKey:@"buyer"];
//            [param setValue:bargainPrice forKey:@"price"];
//            [param setValue:weakSelf.model.carID forKey:@"detailId"];
//            [param setValue:@"1" forKey:@"mark"];
//            [YLDetailTool bargainWithParam:param success:^(NSDictionary * _Nonnull result) {
////                NSLog(@"%@", result);
//                if ([result[@"code"] isEqualToString:@"200"]) {
//                    NSLog(@"砍价成功:%@", result[@"message"]);
//                } else {
//                    NSLog(@"a砍价失败");
//                }
//
//            } failure:nil];
//        } else {
//            YLLoginController *login = [[YLLoginController alloc] init];
//            [weakSelf.navigationController pushViewController:login animated:YES];
//        }
//    };
//    self.cover.hidden = NO;
//    self.cover.bargainBg.hidden = NO;
//    self.cover.orderBg.hidden = YES;
//
//}
//- (void)bargainClick {
//
//    NSLog(@"YLDetailController:点击了砍价");
//    self.cover.salePrice = self.detailModel.price;
//    __weak typeof(self) weakSelf = self;
//    self.cover.bargainBlock = ^(NSString *price) {
//        NSLog(@"砍价的价格是：%@", price);
//        // 判断用户是否登录
//        if (weakSelf.account) {
//            NSString *bargainPrice = [NSString stringWithFormat:@"%.f", [price floatValue] * 10000];
//            // 向后台发送砍价请求
//            NSMutableDictionary *param = [NSMutableDictionary dictionary];
//            [param setValue:weakSelf.detailModel.telephone forKey:@"seller"];
//            [param setValue:weakSelf.account.telephone forKey:@"buyer"];
//            [param setValue:bargainPrice forKey:@"price"];
//            [param setValue:weakSelf.model.carID forKey:@"detailId"];
//            [param setValue:@"1" forKey:@"mark"];
//            [YLDetailTool bargainWithParam:param success:^(NSDictionary * _Nonnull result) {
////                NSLog(@"%@", result);
//                if ([result[@"code"] isEqualToString:@"200"]) {
//                    NSLog(@"砍价成功:%@", result[@"message"]);
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLEVIEW" object:nil];
//                } else {
//                    NSLog(@"a砍价失败");
//                }
//            } failure:nil];
//        } else {
//            YLLoginController *login = [[YLLoginController alloc] init];
//            [weakSelf.navigationController pushViewController:login animated:YES];
//        }
//    };
//    self.cover.hidden = NO;
//    self.cover.bargainBg.hidden = NO;
//    self.cover.orderBg.hidden = YES;
//}
//
//- (void)orderCarClick {
//
//    NSLog(@"YLDetailController:点击了预约看车");
//    __weak typeof(self) weakSelf = self;
//    self.cover.timePickerBlock = ^(NSString *time) {
//        NSLog(@"预约看车时间是：%@", time);
//        // 向后台发送预约看车请求
//        if (weakSelf.account) {
//            NSMutableDictionary *param = [NSMutableDictionary dictionary];
//            [param setValue:weakSelf.account.telephone forKey:@"telephone"];
//            [param setValue:time forKey:@"appointTime"];
//            [param setValue:weakSelf.detailModel.centerId forKey:@"centerId"];
//            [param setValue:weakSelf.model.carID forKey:@"detailId"];
////            [param setValue:@"1" forKey:@"status"];
//            [YLDetailTool lookCarWithParam:param success:^(NSDictionary *result) {
//                NSLog(@"预约看车成功:%@", result);
//                if ([result[@"code"] isEqualToString:@"200"]) {
//                    NSLog(@"预约看车成功");
//                    [weakSelf.footer.order setTitle:@"已预约" forState:UIControlStateNormal];
//                    [weakSelf.footer.order setUserInteractionEnabled:NO];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLEVIEW" object:nil];
//                } else {
//                    NSLog(@"预约失败:%@", result[@"message"]);
//                }
//
//            } failure:nil];
//        } else {
//            YLLoginController *login = [[YLLoginController alloc] init];
//            [weakSelf.navigationController pushViewController:login animated:YES];
//        }
//    };
//    self.cover.hidden = NO;
//    self.cover.bargainBg.hidden = YES;
//    self.cover.orderBg.hidden = NO;
//}

#pragma mark 懒加载
//- (YLCoverView *)cover {
//
//    if (!_cover) {
//        _cover = [[YLCoverView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
//        _cover.hidden = YES;
//        [self.view addSubview:_cover];
//    }
//    return _cover;
//}
//
//- (UIView *)labelView {
//    if (!_labelView) {
//        CGRect frame = CGRectMake(YLLeftMargin, 64 + YLTopMargin, YLScreenWidth - 2 * YLLeftMargin, 180);
//        _labelView = [[UIView alloc] initWithFrame:frame];
//        [self.view addSubview:_labelView];
//    }
//    return _labelView;
//}
//
//- (NSMutableArray *)browsingHistory {
//
//    if (!_browsingHistory) {
//        _browsingHistory = [NSKeyedUnarchiver unarchiveObjectWithFile:YLBrowsingHistoryPath];
//        if (!_browsingHistory) {
//            _browsingHistory = [NSMutableArray array];
//        }
//    }
//    return _browsingHistory;
//}
//
//- (YLAccount *)account {
//
//    if (!_account) {
//        _account = [YLAccountTool account];
//    }
//    return _account;
//}

#pragma mark 私有方法
// 提示弹窗
- (void)showMessage:(NSString *)message {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
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

/**
 保存浏览记录

 @param model 浏览模型对象
 */
- (void)saveBrowseHistory:(YLTableViewModel *)model {
    
    // 判断浏览记录是否已经存在，如果存在，删除旧的，重新添加到数组
    // 遍历的时候不能操作删除和插入，不然会报错
    for (YLTableViewModel *historyModel in self.browsingHistory) {
        if ([historyModel.carID isEqualToString:model.carID]) {
            NSInteger index = [self.browsingHistory indexOfObject:historyModel];
            [self.browsingHistory removeObjectAtIndex:index];
            break;
        }
    }
    [self.browsingHistory insertObject:model atIndex:0];
    
    // 保存到本地
    BOOL success = [NSKeyedArchiver archiveRootObject:self.browsingHistory toFile:YLBrowsingHistoryPath];
    if (success) {
        NSLog(@"保存成功");
    } else {
        NSLog(@"保存失败");
    }
}

#pragma mark 懒加载
- (UIView *)cover {
    if (!_cover) {
        _cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
        _cover.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5];
        _cover.hidden = YES;
    }
    return _cover;
}

- (YLDetailBargainView *)detailBargain {
    if (!_detailBargain) {
        _detailBargain = [[YLDetailBargainView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 213, YLScreenWidth, 213)];
        _detailBargain.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _detailBargain.cancelBlock = ^{
            NSLog(@"取消砍价,退出砍价视图");
            weakSelf.cover.hidden = YES;
            weakSelf.detailBargain.hidden = YES;
        };
        
        // 确定砍价
        _detailBargain.bargainBlock = ^(NSString * _Nonnull price) {
            NSLog(@"砍价成功，价格是%@,退出砍价视图", price);
            // 向后台提交砍价参数请求
            YLAccount *account = [YLAccountTool account];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:weakSelf.detailModel.telephone forKey:@"seller"];
            [param setValue:account.telephone forKey:@"buyer"];
            [param setValue:price forKey:@"price"];
            [param setValue:weakSelf.model.carID forKey:@"detailId"];
            [param setValue:@"1" forKey:@"mark"];
            [YLDetailTool bargainWithParam:param success:^(NSDictionary * _Nonnull result) {
                if ([result[@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                    NSLog(@"砍价成功:%@", result[@"message"]);
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLEVIEW" object:nil];
                } else {
                    NSLog(@"a砍价失败");
                }
            } failure:nil];
            
            weakSelf.cover.hidden = YES;
            weakSelf.detailBargain.hidden = YES;
        };
    }
    return _detailBargain;
}

- (YLDetailOrderTimeView *)detailOrderTime {
    if (!_detailOrderTime) {
        _detailOrderTime = [[YLDetailOrderTimeView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 213, YLScreenWidth, 213)];
        _detailOrderTime.hidden = YES;
        
        __weak typeof(self) weakSelf = self;
        _detailOrderTime.cancelBlock = ^{
            NSLog(@"取消预约看车,退出预约视图");
            weakSelf.cover.hidden = YES;
            weakSelf.detailBargain.hidden = YES;
        };
        
        _detailOrderTime.orderTimeBlock = ^(NSString * _Nonnull orderTime) {
            NSLog(@"选择好预约时间：%@", orderTime);
            weakSelf.cover.hidden = YES;
            weakSelf.detailBargain.hidden = YES;
            
            // 向后台发送预约看车请求
            YLAccount *account = [YLAccountTool account];
            if (account) {
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:account.telephone forKey:@"telephone"];
                [param setValue:orderTime forKey:@"appointTime"];
                [param setValue:weakSelf.detailModel.centerId forKey:@"centerId"];
                [param setValue:weakSelf.model.carID forKey:@"detailId"];
                [YLDetailTool lookCarWithParam:param success:^(NSDictionary *result) {
                    NSLog(@"预约看车成功:%@", result);
                    if ([result[@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                        NSLog(@"预约看车成功");
                        [weakSelf.footer.order setTitle:@"已预约" forState:UIControlStateNormal];
                        [weakSelf.footer.order setUserInteractionEnabled:NO];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLEVIEW" object:nil];
                    } else {
                        NSLog(@"预约失败:%@", result[@"message"]);
                    }

                } failure:nil];
                weakSelf.cover.hidden = YES;
                weakSelf.detailOrderTime.hidden = YES;
                
            } else {
                YLLoginController *login = [[YLLoginController alloc] init];
                [weakSelf.navigationController pushViewController:login animated:YES];
            }
        };
    }
    return _detailOrderTime;
}

@end

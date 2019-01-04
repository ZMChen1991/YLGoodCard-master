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
#import "YLVehicleModel.h"
#import "YLBlemishModel.h"

#import "YLConfigController.h"
#import "YLLoginController.h"

#import "YLAccount.h"
#import "YLAccountTool.h"
#import "YLRequest.h"

#import "YLDetailOrderTimeView.h"
#import "YLDetailBargainView.h"
#import "YLConfigController.h"

// 进入详情页，保存当前汽车的ID
// 详情页数据
#define YLDetailPath(carID) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:carID]
//#define YLDetailPath(carID) [NSTemporaryDirectory() stringByAppendingPathComponent:carID]

@interface YLDetailController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, YLTableGroupHeaderDelegate>

//@property (nonatomic, strong) UIImageView *bg;
//@property (nonatomic, strong) UIView *labelView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YLDetailHeaderView *header;
@property (nonatomic, strong) YLDetailFooterView *footer;
@property (nonatomic, strong) UIView *cover;
@property (nonatomic, strong) YLDetailBargainView *detailBargain;
@property (nonatomic, strong) YLDetailOrderTimeView *detailOrderTime;

@property (nonatomic, strong) YLDetailModel *detailModel;
@property (nonatomic, strong) NSMutableArray *browsingHistory;

@property (nonatomic, strong) NSMutableArray *vehicle;// 细节图片数组
@property (nonatomic, strong) NSMutableArray *blemish;// 瑕疵
@property (nonatomic, strong) NSArray *carInformations;// 车辆图文

@property (nonatomic, strong) NSMutableArray *cars;// 细节图片数组
@property (nonatomic, strong) NSMutableArray *xiaci;// 瑕疵
@property (nonatomic, strong) NSMutableArray *xiaciTitles;// 瑕疵
@property (nonatomic, strong) NSString *isCollect; // 是否收藏
@property (nonatomic, strong) NSString *isBook;// 是否预约看车
@property (nonatomic, strong) YLAccount *account;


@end

@implementation YLDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.carInformations = @[@"正侧",@"正前",@"前排",@"后排",@"中控",@"发动机舱",@"瑕疵"];
    
    [self setupNav];
    [self addTableView];
    [self saveBrowseHistory:self.model];
    [self getLocationData];
    [self loadData];
}

- (void)loadData {
    
//    NSString *tempStr = NSTemporaryDirectory();
//    NSLog(@"tempStr:%@", tempStr);
    
    YLAccount *account = [YLAccountTool account];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = self.model.carID;
    param[@"telephone"] = account.telephone;
    __weak typeof(self) weakSelf = self;
    NSString *urlString = @"http://ucarjava.bceapp.com/detail?method=id";
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSLog(@" 请求成功:%@", YLDetailPath(weakSelf.model.carID));
            [weakSelf keyedArchiverObject:responseObject toFile:YLDetailPath(weakSelf.model.carID)];
            [weakSelf getLocationData];
        }
    } failed:nil];
}

//- (void)dealloc {
//
//    NSLog(@"------dealloc-------");
//}

- (void)getLocationData {
    
    [self.vehicle removeAllObjects];
    [self.cars removeAllObjects];
    [self.blemish removeAllObjects];
    [self.xiaci removeAllObjects];

    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:YLDetailPath(self.model.carID)];
    self.detailModel = [YLDetailModel mj_objectWithKeyValues:dict[@"data"][@"detail"]];
    self.isBook = dict[@"data"][@"isBook"];
    self.isCollect = dict[@"data"][@"isCollect"];
    NSArray *vehicles = [YLVehicleModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"image"][@"vehicle"]];
    NSMutableArray *array = [NSMutableArray array];
    for (YLVehicleModel *model in vehicles) {
        [self.vehicle addObject:model.img];
        [array addObject:model.img];
    }
    if (array.count > 0) {
        [self.cars addObject:array[0]];// 正侧
    }
    if (array.count > 1) {
        [self.cars addObject:array[1]];// 正前
    }
    if (array.count > 19) {
        [self.cars addObject:array[19]];// 前排
    }
    if (array.count > 20) {
        [self.cars addObject:array[20]];// 后排
    }
    if (array.count > 11) {
        [self.cars addObject:array[11]];// 中控
    }
    if (array.count > 23) {
        [self.cars addObject:array[23]];// 发动机舱
    }
//    [self.cars addObject:array[0]];// 正侧
//    [self.cars addObject:array[1]];// 正前
//    [self.cars addObject:array[19]];// 前排
//    [self.cars addObject:array[20]];// 后排
//    [self.cars addObject:array[11]];// 中控
//    [self.cars addObject:array[23]];// 发动机舱
    
//    for (NSInteger i = 0; i < vehicles.count; i++) {
//        YLVehicleModel *model = vehicles[i];
//        [self.vehicle addObject:model.img];
//        if (i == 0 || i == 1 || i == 11 || i == 19 || i == 20 || i == 23) {
//            [self.cars addObject:model.img];
//        }
//    }
    
    NSArray *blemishs = [YLBlemishModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"image"][@"blemish"]];
    for (YLBlemishModel *model in blemishs) {
        [self.blemish addObject:model];
        [self.xiaci addObject:[NSString stringWithFormat:@"%@", model.img]];
        [self.xiaciTitles addObject:model.remarks];
    }
    
    YLDetailHeaderModel *headerModel = [YLDetailHeaderModel mj_objectWithKeyValues:self.detailModel];
    self.header.vehicle = self.vehicle;
    self.header.model = headerModel;
    self.header.detailModel = self.detailModel;
    self.footer.model = self.detailModel;
    self.footer.isCollect = self.isCollect;
    self.footer.isBook = self.isBook;
    self.detailBargain.salePrice = self.detailModel.price;
    
    [self.tableView reloadData];
//    [self.vehicle removeAllObjects];
//    [self.cars removeAllObjects];
//    [self.blemish removeAllObjects];
//    [self.xiaci removeAllObjects];
}

- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"详情数据保存成功");
    } else {
        NSLog(@"保存失败");
    }
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 3) {
//        return self.carInformations.count;
//    }
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
        cell.model = self.detailModel;
        return cell;
    } else {
        YLCarInformationCell *cell = [YLCarInformationCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 这里赋值给cell
//        YLVehicleModel *model = self.vehicle[indexPath.row];
//        cell.image = model.img;
//        cell.title = self.carInformations[indexPath.row];
        for (YLBlemishModel *model in self.blemish) {
            NSLog(@"%@", model.remarks);
        }
        
        cell.blemishTitles = self.xiaciTitles;
        cell.images = self.cars;
        cell.blemishs = self.xiaci;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    CGRect headerRect = CGRectMake(0, 0, YLScreenWidth, 44);
    NSArray *titles = @[@"服务保障",@"基本信息",@"检测报告",@"车辆图文"];
    NSArray *images = @[@"服务保障", @"基本信息", @"检测报告", @"车辆图文"];
    NSArray *details = @[@"", @"更多配置", @"", @""];
    NSArray *arrowImages = @[@"", @"更多", @"", @""];
    YLTableGroupHeader *header = [[YLTableGroupHeader alloc] initWithFrame:headerRect image:images[section] title:titles[section] detailTitle:details[section] arrowImage:arrowImages[section]];
    if (section == 1) {
        header.delegate = self;
    }
//    header.labelBlock = ^() {
//            [self showMessage:@"正在开发中，敬请期待"];
//    };
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
        return 120 + YLLeftMargin;
    }
    if (indexPath.section == 1) {
        return 211;
    }
    if (indexPath.section == 2) {
        return 433 + 1;
    } else {
        return 1625;
    }
}

#pragma mark 添加视图
- (void)addTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight - 60 - 64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak typeof(self) weakSelf = self;
    YLDetailHeaderView *header = [[YLDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 365)];
    header.detailHeaderBargainBlock = ^{
        NSLog(@"点击了砍价,弹出砍价视图");
        [weakSelf bargainClick];
    };
    self.header = header;
    self.tableView.tableHeaderView = header;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.account = [YLAccountTool account];
    
    YLDetailFooterView *footer = [[YLDetailFooterView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 60 - 64, YLScreenWidth, 60)];
    footer.backgroundColor = [UIColor whiteColor];
    footer.collectBlock = ^(NSString *isCollect) {
        if (weakSelf.account) {
            if ([isCollect isEqualToString:@"1"]) {
                // 点击收藏，向后台发送收藏请求
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"1" forKey:@"status"];
                [param setValue:weakSelf.model.carID forKey:@"detailId"];
                [param setValue:weakSelf.account.telephone forKey:@"telephone"];
                NSString *urlString = @"http://ucarjava.bceapp.com/collection?method=upd";
                [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
                    if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                        NSLog(@"收藏成功:%@", responseObject);
                        [weakSelf showMessage:@"收藏成功"];
//                        [weakSelf loadData];
                    } else {
                        NSLog(@"收藏失败:%@", responseObject[@"message"]);
                        [weakSelf showMessage:@"收藏失败，请再试一次"];
                    }
                } failed:nil];
            } else {
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"0" forKey:@"status"];
                [param setValue:weakSelf.model.carID forKey:@"detailId"];
                [param setValue:weakSelf.account.telephone forKey:@"telephone"];
                NSString *urlString = @"http://ucarjava.bceapp.com/collection?method=upd";
                [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
                    if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                        NSLog(@"取消收藏:%@", responseObject);
                        [weakSelf showMessage:@"已取消收藏"];
                        //                        [weakSelf loadData];
                    } else {
                        NSLog(@"取消收藏失败:%@", responseObject[@"message"]);
                        [weakSelf showMessage:@"取消收藏失败，请再试一次"];
                    }
                } failed:nil];
//                [YLDetailTool favoriteWithParam:param success:^(NSDictionary *result) {
//                    NSLog(@"点击了取消收藏按钮:%@", result);
//                    [weakSelf showMessage:@"取消收藏"];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLEVIEW" object:nil];
//                } failure:nil];
            }
        } else {
            YLLoginController *login = [[YLLoginController alloc] init];
            login.loginBlock = ^(NSString *string) {
                weakSelf.account = [YLAccountTool account];
            };
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
    // 修改导航标题
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)pushMoreControl {

    NSLog(@"pushMoreControl");
    YLConfigController *config = [[YLConfigController alloc] init];
    config.model = self.detailModel;
    [self.navigationController pushViewController:config animated:YES];
}

#pragma mark 砍价
- (void)bargainClick {

    self.account = [YLAccountTool account];
    // 判断用户是否登录
    if (self.account) {
        NSLog(@"点击了砍价,弹出砍价视图");
        self.cover.hidden = NO;
        self.detailBargain.hidden = NO;
        self.detailOrderTime.hidden = YES;
    } else {
        // 没有登录，跳转登录界面
        YLLoginController *login = [[YLLoginController alloc] init];
        __weak typeof(self) weakSelf = self;
        login.loginBlock = ^(NSString *string) {
            weakSelf.account = [YLAccountTool account];
        };
        [self.navigationController pushViewController:login animated:YES];
    }
}

#pragma mark 预约看车
- (void)orderCarClick {
    NSLog(@"点击了预约看车，弹出预约看车视图");
    self.account = [YLAccountTool account];
    // 判断用户是否登录
    if (self.account) {
        NSLog(@"点击了预约看车，弹出预约看车视图");
        self.cover.hidden = NO;
        self.detailOrderTime.hidden = NO;
        self.detailBargain.hidden = YES;
    } else {
        // 没有登录，跳转登录界面
        YLLoginController *login = [[YLLoginController alloc] init];
        __weak typeof(self) weakSelf = self;
        login.loginBlock = ^(NSString *string) {
            weakSelf.account = [YLAccountTool account];
        };
        [self.navigationController pushViewController:login animated:YES];
    }
}

#pragma mark 私有方法
// 提示弹窗
- (void)showMessage:(NSString *)message {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
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
            NSLog(@"已删除旧的");
            break;
        }
    }
    [self.browsingHistory insertObject:model atIndex:0];
//    NSLog(@"保存");
    
    // 保存到本地
    BOOL success = [NSKeyedArchiver archiveRootObject:self.browsingHistory toFile:YLBrowsingHistoryPath];
    if (success) {
        NSLog(@"浏览记录保存成功：%@", YLBrowsingHistoryPath);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLEVIEW" object:nil];
    } else {
        NSLog(@"浏览保存失败");
    }
}

- (void)tap {
//    NSLog(@"tap");
    self.cover.hidden = YES;
    self.detailBargain.hidden = YES;
    self.detailOrderTime.hidden = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.detailBargain] || [touch.view isDescendantOfView:self.detailOrderTime]) {
//        NSLog(@"detailBargain");
        return NO;
    }
    return YES;
}

#pragma mark 懒加载
- (void)setModel:(YLTableViewModel *)model {
    _model = model;
    [self loadData];
}

- (UIView *)cover {
    if (!_cover) {
        _cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
        _cover.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5];
        _cover.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tap.delegate = self;
        [_cover addGestureRecognizer:tap];
        [_cover setUserInteractionEnabled:YES];
    }
    return _cover;
}

- (NSMutableArray *)browsingHistory {
    
    if (!_browsingHistory) {
//        NSLog(@"%@", YLBrowsingHistoryPath);
        _browsingHistory = [NSKeyedUnarchiver unarchiveObjectWithFile:YLBrowsingHistoryPath];
        if (!_browsingHistory) {
            _browsingHistory = [NSMutableArray array];
        }
    }
    return _browsingHistory;
}

- (YLDetailBargainView *)detailBargain {
    if (!_detailBargain) {
        _detailBargain = [[YLDetailBargainView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 213 - 64, YLScreenWidth, 213)];
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
                    [weakSelf showMessage:@"砍价成功"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLEVIEW" object:nil];
                } else {
                    NSLog(@"a砍价失败");
                    [weakSelf showMessage:@"砍价失败"];
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
        _detailOrderTime = [[YLDetailOrderTimeView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 213 - 64, YLScreenWidth, 213)];
        _detailOrderTime.hidden = YES;
        
        __weak typeof(self) weakSelf = self;
        _detailOrderTime.cancelBlock = ^{
            NSLog(@"取消预约看车,退出预约视图");
            weakSelf.cover.hidden = YES;
            weakSelf.detailOrderTime.hidden = YES;
        };
        
        _detailOrderTime.orderTimeBlock = ^(NSString * _Nonnull orderTime) {
            NSLog(@"选择好预约时间：%@", orderTime);
//            weakSelf.cover.hidden = YES;
//            weakSelf.detailBargain.hidden = YES;
            
            // 向后台发送预约看车请求
            YLAccount *account = [YLAccountTool account];
            if (account) {
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:account.telephone forKey:@"buyer"];
                [param setValue:orderTime forKey:@"appointTime"];
                [param setValue:weakSelf.detailModel.centerId forKey:@"centerId"];
                [param setValue:weakSelf.model.carID forKey:@"detailId"];
                [param setValue:weakSelf.detailModel.telephone forKey:@"seller"];
                [YLDetailTool lookCarWithParam:param success:^(NSDictionary *result) {
                    NSLog(@"预约看车成功:%@", result);
                    [weakSelf showMessage:@"预约看车成功"];
                    if ([result[@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                        NSLog(@"预约看车成功");
                        [weakSelf.footer.order setTitle:@"已预约" forState:UIControlStateNormal];
                        [weakSelf.footer.order setUserInteractionEnabled:NO];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHTABLEVIEW" object:nil];
                    } else {
                        NSLog(@"预约失败:%@", result[@"message"]);
                        [weakSelf showMessage:@"预约失败,请再试一次"];
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

- (NSMutableArray *)vehicle {
    if (!_vehicle) {
        _vehicle = [NSMutableArray array];
    }
    return _vehicle;
}

- (NSMutableArray *)blemish {
    if (!_blemish) {
        _blemish = [NSMutableArray array];
    }
    return _blemish;
}

- (NSMutableArray *)cars {
    if (!_cars) {
        _cars = [NSMutableArray array];
    }
    return _cars;
}

- (NSMutableArray *)xiaci {
    if (!_xiaci) {
        _xiaci = [NSMutableArray array];
    }
    return _xiaci;
}
- (NSMutableArray *)xiaciTitles {
    if (!_xiaciTitles) {
        _xiaciTitles = [NSMutableArray array];
    }
    return _xiaciTitles;
}
@end

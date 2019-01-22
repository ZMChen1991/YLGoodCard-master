//
//  YLOrderController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
// 预约卖车页面

#import "YLOrderController.h"
#import "YLReservationController.h"
#import "YLDetectBrandController.h"
#import "YLDetectCenterController.h"

#import "YLOrderView.h"
#import "YLSaleCarWriteCell.h"
#import "YLSaleCarChoiceCell.h"
#import "YLTimePicker.h"
#import "YLYearMonthPicker.h"
#import "YLYearMonthDayPicker.h"

#import "YLRequest.h"

@interface YLOrderController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *cover; // 蒙板
@property (nonatomic, strong) NSMutableArray *detailArray;
@property (nonatomic, strong) NSMutableArray *brands;

// 预约卖车-咨询
@property (nonatomic, strong) YLOrderView *orderView;

@property (nonatomic, strong) NSArray *titles;

// 提交的参数
@property (nonatomic, strong) NSMutableDictionary *param;

@property (nonatomic, strong) YLDetectCenterModel *detectCenterModel;
@property (nonatomic, strong) NSString *checkOut;



@end

@implementation YLOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
//    [self addNotification];
}

- (void)dealloc {
    NSLog(@"____dealloc____");
}

//- (void)addNotification {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transformView:) name:@"UIKeyboardWillChangeFrameNotification" object:nil];
//}

//- (void)viewWillDisappear:(BOOL)animated {
//    NSLog(@"viewWillDisappear");
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIKeyboardWillChangeFrameNotification" object:nil];
//}

- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    __weak typeof(self) weakSelf = self;
    YLOrderView *orderView = [[YLOrderView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 130)];
    orderView.orderSaleBlock = ^{
        NSLog(@"确认预约卖车");
        if ([weakSelf isFullMessage]) {
            NSString *examineTime = [NSString stringWithFormat:@"%@ %@", self.detailArray[6], self.detailArray[7]];
            [weakSelf.param setValue:examineTime forKey:@"examineTime"];
            // 提交卖车信息到后台
            NSString *urlString = @"http://ucarjava.bceapp.com/sell?method=order";
            [YLRequest GET:urlString parameters:weakSelf.param success:^(id  _Nonnull responseObject) {
                NSLog(@"%@", responseObject);
                if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                    NSLog(@"预约卖车成功");
                    YLReservationController *reservationVc = [[YLReservationController alloc] init];
                    // 这里传需要的参数，可以使用数组或字典存放相关的参数
                    reservationVc.detectCenterModel = weakSelf.detectCenterModel;
                    reservationVc.checkOut = examineTime;
                    [weakSelf.navigationController pushViewController:reservationVc animated:YES];
                } else {
                    NSLog(@"预约卖车失败：%@", responseObject[@"message"]);
                    [weakSelf showMessage:@"请输入完整信息"];
                }
            } failed:nil];
            
        } else {
            [weakSelf showMessage:@"请输入完整信息"];
        }
    };
    
    self.tableView.tableFooterView = orderView;
    self.orderView = orderView;
    
    [self.view addSubview:self.cover];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {
        YLSaleCarChoiceCell *cell = [YLSaleCarChoiceCell cellWithTableView:tableView];
        cell.choiceBlock = ^{
            [weakSelf showMessage:@"目前只支持阳江地区"];
        };
        cell.title = self.titles[indexPath.row];
        cell.detailTitle = self.detailArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.row == 1) {
        YLSaleCarChoiceCell *cell = [YLSaleCarChoiceCell cellWithTableView:tableView];
        cell.choiceBlock = ^{
            YLDetectCenterController *detcetCenter = [[YLDetectCenterController alloc] init];
            detcetCenter.city = self.detailArray[0];
            detcetCenter.detectCenterBlock = ^(YLDetectCenterModel * _Nonnull model) {
                NSLog(@"选择的检测中心是：%@", model.name);
                weakSelf.detectCenterModel = model;
                [weakSelf.param setValue:model.ID forKey:@"centerId"];
                [weakSelf.param setValue:@"阳江" forKey:@"city"];
                [weakSelf.detailArray replaceObjectAtIndex:1 withObject:model.name];
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:detcetCenter animated:YES];
        };
        cell.title = self.titles[indexPath.row];
        cell.detailTitle = self.detailArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.row == 2) {
        YLSaleCarChoiceCell *cell = [YLSaleCarChoiceCell cellWithTableView:tableView];
        cell.choiceBlock = ^{
            YLDetectBrandController *brand = [[YLDetectBrandController alloc] init];
            brand.brandBlock = ^(NSString * _Nonnull carType, NSString * _Nonnull typeId) {
                NSLog(@"carType%@- %@", carType, typeId);
                [weakSelf.param setValue:typeId forKey:@"typeId"];
                [weakSelf.detailArray replaceObjectAtIndex:2 withObject:carType];
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:brand animated:YES];
        };
        cell.title = self.titles[indexPath.row];
        cell.detailTitle = self.detailArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.row == 3) {
        YLSaleCarWriteCell *cell = [YLSaleCarWriteCell cellWithTableView:tableView];
        cell.writeBlock = ^(NSString * _Nonnull detailTitle) {// 上牌城市
            NSLog(@"%ld--:%@",indexPath.row, detailTitle);
            [weakSelf.param setValue:detailTitle forKey:@"location"];
            [weakSelf.detailArray replaceObjectAtIndex:indexPath.row withObject:detailTitle];
        };
        cell.title = self.titles[indexPath.row];
        cell.detailTitle = self.detailArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.row == 4) {
        YLSaleCarChoiceCell *cell = [YLSaleCarChoiceCell cellWithTableView:tableView];
        cell.choiceBlock = ^{
            NSLog(@"弹出时间弹窗");
            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
            UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
            cover.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.1];
            [window addSubview:cover];
            YLYearMonthPicker *pick = [[YLYearMonthPicker alloc] initWithFrame:CGRectMake(0, 250, YLScreenWidth, 150)];
            pick.cancelBlock = ^{
                [cover removeFromSuperview];
            };
            pick.sureBlock = ^(NSString * _Nonnull licenseTime) {
                NSLog(@"licenseTime:%@", licenseTime);
                [weakSelf.param setValue:licenseTime forKey:@"licenseTime"];
                [weakSelf.detailArray replaceObjectAtIndex:indexPath.row withObject:licenseTime];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [cover removeFromSuperview];
            };
            [cover addSubview:pick];
        };
        cell.title = self.titles[indexPath.row];
        cell.detailTitle = self.detailArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.row == 5) {
        YLSaleCarWriteCell *cell = [YLSaleCarWriteCell cellWithTableView:tableView];
        cell.writeBlock = ^(NSString * _Nonnull detailTitle) { // 行驶里程
            NSLog(@"%ld--:%@",indexPath.row, detailTitle);
            [weakSelf.param setValue:detailTitle forKey:@"course"];
            [weakSelf.detailArray replaceObjectAtIndex:indexPath.row withObject:detailTitle];
        };
        cell.title = self.titles[indexPath.row];
        cell.detailTitle = self.detailArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 6) { // 验车日期
        YLSaleCarChoiceCell *cell = [YLSaleCarChoiceCell cellWithTableView:tableView];
        cell.choiceBlock = ^{
            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
            UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
            cover.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.1];
            [window addSubview:cover];
            YLYearMonthDayPicker *pick = [[YLYearMonthDayPicker alloc] initWithFrame:CGRectMake(0, 250, [UIScreen mainScreen].bounds.size.width, 150)];
            pick.cancelBlock = ^{
                [cover removeFromSuperview];
            };
            pick.sureBlock = ^(NSString * _Nonnull licenseTime) {
//                NSLog(@"licenseTime:%@", licenseTime);
//                [weakSelf.param setValue:licenseTime forKey:@"examineTime"];
                [weakSelf.detailArray replaceObjectAtIndex:indexPath.row withObject:licenseTime];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [cover removeFromSuperview];
            };
            [cover addSubview:pick];
            
            
        };
        cell.title = self.titles[indexPath.row];
        cell.detailTitle = self.detailArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.row == 7) { // 验车时间
        YLSaleCarChoiceCell *cell = [YLSaleCarChoiceCell cellWithTableView:tableView];
        cell.choiceBlock = ^{
            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
            UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
            cover.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.1];
            [window addSubview:cover];
            YLTimePicker *pick = [[YLTimePicker alloc] initWithFrame:CGRectMake(0, 250, [UIScreen mainScreen].bounds.size.width, 150)];
            pick.cancelBlock = ^{
                [cover removeFromSuperview];
            };
            pick.sureBlock = ^(NSString * _Nonnull time) {
                NSLog(@"licenseTime:%@", time);
                [weakSelf.detailArray replaceObjectAtIndex:indexPath.row withObject:time];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [cover removeFromSuperview];
            };
            [cover addSubview:pick];
        };
        cell.title = self.titles[indexPath.row];
        cell.detailTitle = self.detailArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        YLSaleCarChoiceCell *cell = [YLSaleCarChoiceCell cellWithTableView:tableView];
        cell.choiceBlock = ^{
            NSLog(@"弹出电话弹窗");
        };
        cell.title = self.titles[indexPath.row];
        cell.detailTitle = self.detailArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    __weak typeof(self) weakSelf = self;
//
//    if (indexPath == 0) { // 城市
//        [self showMessage:@"目前只支持阳江地区"];
//    }
//    if (indexPath.row == 1) {// 检测中心
//        YLDetectCenterController *detcetCenter = [[YLDetectCenterController alloc] init];
//        detcetCenter.city = self.detailArray[0];
//        detcetCenter.detectCenterBlock = ^(YLDetectCenterModel * _Nonnull model) {
//            NSLog(@"选择的检测中心是：%@", model.name);
//            weakSelf.detectCenterModel = model;
//            [weakSelf.param setValue:model.ID forKey:@"centerId"];
//            [weakSelf.param setValue:@"阳江" forKey:@"city"];
//            [weakSelf.detailArray replaceObjectAtIndex:1 withObject:model.name];
//            [weakSelf.tableView reloadData];
//        };
//        [self.navigationController pushViewController:detcetCenter animated:YES];
//    }
//
//    if (indexPath.row == 2) {// 品牌-车系-车型
//        YLDetectBrandController *brand = [[YLDetectBrandController alloc] init];
//        brand.brandBlock = ^(NSString * _Nonnull carType, NSString * _Nonnull typeId) {
//            NSLog(@"carType%@- %@", carType, typeId);
//            [weakSelf.param setValue:typeId forKey:@"typeId"];
//            [weakSelf.detailArray replaceObjectAtIndex:2 withObject:carType];
//            [weakSelf.tableView reloadData];
//        };
//        [self.navigationController pushViewController:brand animated:YES];
//    }
//}

#pragma mark 弹出键盘，视图往上移动
//- (void)transformView:(NSNotification *)notification {
//    // 获取键盘弹出的rect
//    NSValue *keyBoardBeginBounds = [[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGRect beginRect = [keyBoardBeginBounds CGRectValue];
//
//    // 获取键盘弹出后的rect
//    NSValue *keyBoardEndBounds = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect endRect = [keyBoardEndBounds CGRectValue];
//
//    // 获取键盘位置变化前后纵坐标Y的变化值
//    CGFloat deltaY = endRect.origin.y - beginRect.origin.y;
//    NSLog(@"%f", deltaY);
////    __weak typeof(self) weakSelf = self;
////    [UIView animateWithDuration:0.25 animations:^{
////        [weakSelf.cityView setFrame:CGRectMake(weakSelf.cityView.frame.origin.x, weakSelf.cityView.frame.origin.y + deltaY, weakSelf.cityView.frame.size.width, weakSelf.cityView.frame.size.height)];
////        [weakSelf.courseView setFrame:CGRectMake(weakSelf.courseView.frame.origin.x, weakSelf.courseView.frame.origin.y + deltaY, weakSelf.courseView.frame.size.width, weakSelf.courseView.frame.size.height)];
////    }];
//}

- (BOOL)isFullMessage {
    
    NSInteger count = self.detailArray.count;
    BOOL isFull = YES;
    for (NSInteger i = 0; i < count; i++) {
        NSString *str = self.detailArray[i];
        if ([NSString isBlankString:str]) {
            isFull = NO;
        }
        if ([str isEqualToString:@"请输入"] || [str isEqualToString:@"请输入(单位:万公里)"] || [str isEqualToString:@"请选择"]) {
            isFull = NO;
            break;
        } else {
            isFull = YES;
        }
    }
    return isFull;
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

- (void)tap {
    self.cover.hidden = YES;
}

#pragma mark 懒加载
- (void)setTelephone:(NSString *)telephone {
    _telephone = telephone;
    // 添加参数电话
    [self.param setValue:telephone forKey:@"telephone"];
    [self.detailArray replaceObjectAtIndex:self.detailArray.count-1 withObject:telephone];
}

- (UIView *)cover {
    
    if (!_cover) {
        _cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
        _cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _cover.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tap.delegate = self;
        [_cover addGestureRecognizer:tap];
        [_cover setUserInteractionEnabled:YES];
    }
    return _cover;
}


- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"城市", @"检测中心", @"选择车型",@"上牌城市", @"上牌时间", @"行驶里程(:万公里)", @"验车日期", @"验车时间", @"联系电话"];
    }
    return _titles;
}
- (NSMutableArray *)detailArray {
    if (!_detailArray) {
        _detailArray = [NSMutableArray arrayWithObjects:@"阳江",@"请选择",@"请选择",@"请输入",@"请选择",@"请输入",@"请选择",@"请选择", @"请选择", nil];
    }
    return _detailArray;
}

- (NSMutableDictionary *)param {
    if (!_param) {
        _param = [NSMutableDictionary dictionary];
    }
    return _param;
}

@end

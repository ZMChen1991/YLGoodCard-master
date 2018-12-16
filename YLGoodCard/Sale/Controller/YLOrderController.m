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

#import "YLCourseView.h"
#import "YLCityView.h"
#import "YLYearMonthPicker.h"
#import "YLAllTimePicker.h"
#import "YLOrderView.h"

#import "YLRequest.h"

@interface YLOrderController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *cover; // 蒙板
@property (nonatomic, strong) NSMutableArray *detailArray;
@property (nonatomic, strong) NSMutableArray *brands;
//
//@property (nonatomic, strong) YLBrandView *brandView;
//@property (nonatomic, strong) YLSeriesView *seriesView;
//@property (nonatomic, strong) YLCartypeView *carTypeView;
@property (nonatomic, strong) YLCourseView *courseView;
@property (nonatomic, strong) YLCityView *cityView;
@property (nonatomic, strong) YLYearMonthPicker *licenseTimeView;
@property (nonatomic, strong) YLAllTimePicker *checkTimeView;

// 预约卖车-咨询
@property (nonatomic, strong) YLOrderView *orderView;


//@property (nonatomic, strong) NSString *brand;
//@property (nonatomic, strong) NSString *series;
//@property (nonatomic, strong) NSString *carType;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transformView:) name:@"UIKeyboardWillChangeFrameNotification" object:nil];
}

- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    YLOrderView *orderView = [[YLOrderView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 130)];
    orderView.orderSaleBlock = ^{
        NSLog(@"确认预约卖车");
        if ([self isFullMessage]) {
            YLReservationController *reservationVc = [[YLReservationController alloc] init];
            // 这里传需要的参数，可以使用数组或字典存放相关的参数
            reservationVc.detectCenterModel = self.detectCenterModel;
            reservationVc.checkOut = self.checkOut;
            
            // 提交卖车信息到后台
            NSString *urlString = @"http://ucarjava.bceapp.com/sell?method=order";
            [YLRequest GET:urlString parameters:self.param success:^(id  _Nonnull responseObject) {
                NSLog(@"%@", responseObject);
                if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                    NSLog(@"预约卖车成功");
                } else {
                    NSLog(@"预约卖车失败：%@", responseObject[@"message"]);
                }
                
            } failed:nil];
            [self.navigationController pushViewController:reservationVc animated:YES];
        } else {
            [self showMessage:@"请输入完整信息"];
        }
    };
    
    orderView.consultBlock = ^{
        
    };
    self.tableView.tableFooterView = orderView;
    self.orderView = orderView;
    
    [self.view addSubview:self.cover];
    [self.cover addSubview:self.cityView];
    [self.cover addSubview:self.courseView];
    [self.cover addSubview:self.licenseTimeView];
    [self.cover addSubview:self.checkTimeView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = self.detailArray[indexPath.row];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    
    if (indexPath == 0) { // 城市
        [self showMessage:@"目前只支持阳江地区"];
    }
    if (indexPath.row == 1) {// 检测中心
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
        [self.navigationController pushViewController:detcetCenter animated:YES];
    }
    
    if (indexPath.row == 2) {// 品牌-车系-车型
        YLDetectBrandController *brand = [[YLDetectBrandController alloc] init];
        brand.brandBlock = ^(NSString * _Nonnull carType, NSString * _Nonnull typeId) {
            NSLog(@"carType%@- %@", carType, typeId);
            [weakSelf.param setValue:typeId forKey:@"typeId"];
            [weakSelf.detailArray replaceObjectAtIndex:2 withObject:carType];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:brand animated:YES];
    }
    if (indexPath.row == 3) {// 上牌城市
        self.cover.hidden = NO;
        self.cityView.hidden = NO;
    }
    if (indexPath.row == 4) {// 上牌时间
        self.cover.hidden = NO;
        self.licenseTimeView.hidden = NO;
    }
    if (indexPath.row == 5) {// 行驶里程:(万公里)
        self.cover.hidden = NO;
        self.courseView.hidden = NO;
    }
    if (indexPath.row == 6) {//验车时间
        self.cover.hidden = NO;
        self.checkTimeView.hidden = NO;
    }
}

#pragma mark 弹出键盘，视图往上移动
- (void)transformView:(NSNotification *)notification {
    // 获取键盘弹出的rect
    NSValue *keyBoardBeginBounds = [[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect = [keyBoardBeginBounds CGRectValue];
    
    // 获取键盘弹出后的rect
    NSValue *keyBoardEndBounds = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect endRect = [keyBoardEndBounds CGRectValue];
    
    // 获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY = endRect.origin.y - beginRect.origin.y;
    NSLog(@"%f", deltaY);
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.cityView setFrame:CGRectMake(self.cityView.frame.origin.x, self.cityView.frame.origin.y + deltaY, self.cityView.frame.size.width, self.cityView.frame.size.height)];
        [self.courseView setFrame:CGRectMake(self.courseView.frame.origin.x, self.courseView.frame.origin.y + deltaY, self.courseView.frame.size.width, self.courseView.frame.size.height)];
    }];
}

- (BOOL)isFullMessage {
    
    NSInteger count = self.detailArray.count;
    BOOL isFull = YES;
    for (NSInteger i = 0; i < count; i++) {
        NSString *str = self.detailArray[i];
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

#pragma mark 懒加载
- (void)setTelephone:(NSString *)telephone {
    _telephone = telephone;
    // 添加参数电话
    [self.param setValue:telephone forKey:@"telephone"];
    [self.detailArray replaceObjectAtIndex:self.detailArray.count-1 withObject:telephone];
}

- (UIView *)cover {
    
    if (!_cover) {
        _cover = [[UIView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, YLScreenHeight)];
        _cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _cover.hidden = YES;
    }
    return _cover;
}


- (YLCourseView *)courseView {
    if (!_courseView) {
        _courseView = [[YLCourseView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 150 - 64, YLScreenWidth, 150)];
        _courseView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _courseView.cancelBlock = ^{
            weakSelf.cover.hidden = YES;
            weakSelf.courseView.hidden = YES;
            [weakSelf.detailArray replaceObjectAtIndex:5 withObject:@"请输入(单位:万公里)"];
            [weakSelf.tableView reloadData];
        };
        _courseView.sureBlock = ^(NSString * _Nonnull course) {
            NSLog(@"%@", course);
            [weakSelf.param setValue:course forKey:@"course"];
            [weakSelf.detailArray replaceObjectAtIndex:5 withObject:course];
            [weakSelf.tableView reloadData];
            weakSelf.cover.hidden = YES;
            weakSelf.courseView.hidden = YES;
        };
    }
    return _courseView;
}

- (YLAllTimePicker *)checkTimeView {
    if (!_checkTimeView) {
        _checkTimeView = [[YLAllTimePicker alloc] initWithFrame:CGRectMake(0, 200, YLScreenWidth, 215)];
        _checkTimeView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _checkTimeView.cancelBlock = ^{
            weakSelf.cover.hidden = YES;
            weakSelf.checkTimeView.hidden = YES;
            [weakSelf.detailArray replaceObjectAtIndex:6 withObject:@"请输入"];
            [weakSelf.tableView reloadData];
        };
        _checkTimeView.sureBlock = ^(NSString * _Nonnull checkOut) {
            NSLog(@"checkOut :%@", checkOut);
            [weakSelf.param setValue:checkOut forKey:@"examineTime"];
            weakSelf.checkOut = checkOut;
            [weakSelf.detailArray replaceObjectAtIndex:6 withObject:checkOut];
            [weakSelf.tableView reloadData];
            weakSelf.cover.hidden = YES;
            weakSelf.checkTimeView.hidden = YES;
        };
    }
    return _checkTimeView;
}

- (YLYearMonthPicker *)licenseTimeView {
    if (!_licenseTimeView) {
        _licenseTimeView = [[YLYearMonthPicker alloc] initWithFrame:CGRectMake(0, 200, YLScreenWidth, 155)];
        _licenseTimeView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _licenseTimeView.cancelBlock = ^{
            weakSelf.cover.hidden = YES;
            weakSelf.licenseTimeView.hidden = YES;
            [weakSelf.detailArray replaceObjectAtIndex:4 withObject:@"请输入"];
            [weakSelf.tableView reloadData];
        };
        _licenseTimeView.sureBlock = ^(NSString * _Nonnull licenseTime) {
            [weakSelf.param setValue:licenseTime forKey:@"licenseTime"];
            weakSelf.checkOut = licenseTime;
            [weakSelf.detailArray replaceObjectAtIndex:4 withObject:licenseTime];
            [weakSelf.tableView reloadData];
            weakSelf.cover.hidden = YES;
            weakSelf.licenseTimeView.hidden = YES;
        };
    }
    return _licenseTimeView;
}

- (YLCityView *)cityView {
    if (!_cityView) {
        _cityView = [[YLCityView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 150 - 64, YLScreenWidth, 150)];
        _cityView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _cityView.cancelBlock = ^{
            weakSelf.cover.hidden = YES;
            weakSelf.cityView.hidden = YES;
            [weakSelf.detailArray replaceObjectAtIndex:3 withObject:@"请输入(单位:万公里)"];
            [weakSelf.tableView reloadData];
        };
        _cityView.sureBlock = ^(NSString * _Nonnull location) {
            NSLog(@"%@", location);
            [weakSelf.param setValue:location forKey:@"location"];
            [weakSelf.detailArray replaceObjectAtIndex:3 withObject:location];
            [weakSelf.tableView reloadData];
            weakSelf.cover.hidden = YES;
            weakSelf.cityView.hidden = YES;
        };
    }
    return _cityView;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"城市", @"检测中心", @"选择车型",@"上牌城市", @"上牌时间", @"行驶里程(:万公里)", @"验车时间", @"联系电话"];
    }
    return _titles;
}
- (NSMutableArray *)detailArray {
    if (!_detailArray) {
        _detailArray = [NSMutableArray arrayWithObjects:@"阳江",@"请选择",@"请选择",@"请输入",@"请输入",@"请输入(单位:万公里)",@"请输入",@"请选择", nil];
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

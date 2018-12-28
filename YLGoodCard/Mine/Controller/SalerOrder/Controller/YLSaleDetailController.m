//
//  YLSaleDetailController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSaleDetailController.h"
#import "YLCommandView.h"
#import "YLCondition.h"
#import "YLChangePriceView.h"
#import "YLStepView.h"
#import "YLLookCarNumberView.h"
#import "YLRequest.h"
#import "YLSaleOrderModel.h"
#import "YLDetailController.h"

#define YLSaleDetailPath(carID) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"SaleDetail-%@", carID]]

@interface YLSaleDetailController ()

@property (nonatomic, strong) UIView *cover;
@property (nonatomic, strong) YLChangePriceView *changePriceView;
@property (nonatomic, strong) YLCondition *changePrice;
@property (nonatomic, strong) YLCondition *soldOut;
@property (nonatomic, strong) YLCondition *repeatOn;
@property (nonatomic, strong) YLStepView *stepView;
@property (nonatomic, strong) YLCommandView *command;
@property (nonatomic, strong) YLLookCarNumberView *numberView;

@property (nonatomic, strong) YLSaleOrderModel *saleOrderModel;

@end

@implementation YLSaleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"卖车订单详情";
    
    [self setupUI];
    [self getLocalData];
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transformView:) name:@"UIKeyboardWillChangeFrameNotification" object:nil];
}

- (void)loadData {
    NSString *urlString = @"http://ucarjava.bceapp.com/sell?method=record";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.model.detail.carID forKey:@"detailId"];
    __weak typeof(self) weakSelf = self;
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSLog(@"请求成功:%@", responseObject[@"data"]);
            [weakSelf keyedArchiverObject:responseObject toFile:YLSaleDetailPath(weakSelf.model.detail.carID)];
            [weakSelf getLocalData];
            
//            self.saleOrderModel = [YLSaleOrderModel mj_objectWithKeyValues:responseObject[@"data"]];
//            NSLog(@"self.saleOrderModel%@", self.saleOrderModel.examineTime);
//            self.command.model = self.saleOrderModel;
//            // 根据车辆状态修改显示修改价格、下架和重新上架的按钮还有进度条的位置
//            if ([self.saleOrderModel.detail.status isEqualToString:@"3"]) { // 车辆在售状态、显示修改价格、下架
//                self.changePrice.hidden = NO;
//                self.soldOut.hidden = NO;
//                self.stepView.hidden = NO;
//                self.repeatOn.hidden = YES;
//                CGRect frame = CGRectMake(0, CGRectGetMaxY(self.changePrice.frame) + 20, YLScreenWidth, 100);
//                [self.stepView setFrame:frame];
//                self.numberView.frame = CGRectMake(0, CGRectGetMaxY(self.stepView.frame), YLScreenWidth, 30);
//            } else if ([self.saleOrderModel.detail.status isEqualToString:@"0"]) { // 车辆下架状态，显示重新上架按钮
//                self.changePrice.hidden = YES;
//                self.soldOut.hidden = YES;
//                self.stepView.hidden = YES;
//                self.repeatOn.hidden = NO;
////                CGRect frame = CGRectMake(0, CGRectGetMaxY(self.repeatOn.frame) + 20, YLScreenWidth, 100);
////                [self.stepView setFrame:frame];
//                self.numberView.frame = CGRectMake(0, CGRectGetMaxY(self.repeatOn.frame) + YLLeftMargin, YLScreenWidth, 30);
//            } else {// d车辆未上架：待验车、待约定状态，不显示修改价格、上架、重新上架的按钮
//                self.changePrice.hidden = YES;
//                self.soldOut.hidden = YES;
//                self.repeatOn.hidden = YES;
//                self.stepView.hidden = NO;
//                CGRect frame = CGRectMake(0, CGRectGetMaxY(self.command.frame) + 20, YLScreenWidth, 100);
//                [self.stepView setFrame:frame];
//                self.numberView.frame = CGRectMake(0, CGRectGetMaxY(self.stepView.frame), YLScreenWidth, 30);
//            }
//
//            if ([self.saleOrderModel.detail.status isEqualToString:@"0"]) { // 车辆下架状态，显示重新上架按钮
//                self.stepView.stepIndex = 0;
//            } else {
//                // 根据订单状态修改进度条
//                if ([self.saleOrderModel.status isEqualToString:@"1"]) {
//                    self.stepView.stepIndex = 0;
//                } else if ([self.saleOrderModel.status isEqualToString:@"2"]) {
//                    self.stepView.stepIndex = 1;
//                } else if ([self.saleOrderModel.status isEqualToString:@"3"]) {
//                    self.stepView.stepIndex = 2;
//                } else {
//                    self.stepView.stepIndex = 3;
//                }
//            }
//
//            self.numberView.tureNumber = self.saleOrderModel.detail.lookSum;
//            self.numberView.browseNumber = self.saleOrderModel.detail.clickSum;
        }
    } failed:nil];
}


- (void)getLocalData {
    
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:YLSaleDetailPath(self.model.detail.carID)];
    self.saleOrderModel = [YLSaleOrderModel mj_objectWithKeyValues:dict[@"data"]];
    NSLog(@"self.saleOrderModel%@", self.saleOrderModel.examineTime);
    self.command.model = self.saleOrderModel;
    // 根据车辆状态修改显示修改价格、下架和重新上架的按钮还有进度条的位置
    if ([self.saleOrderModel.detail.status isEqualToString:@"3"]) { // 车辆在售状态、显示修改价格、下架
        self.changePrice.hidden = NO;
        self.soldOut.hidden = NO;
        self.stepView.hidden = NO;
        self.repeatOn.hidden = YES;
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.changePrice.frame) + 20, YLScreenWidth, 100);
        [self.stepView setFrame:frame];
        self.numberView.frame = CGRectMake(0, CGRectGetMaxY(self.stepView.frame), YLScreenWidth, 30);
    } else if ([self.saleOrderModel.detail.status isEqualToString:@"0"]) { // 车辆下架状态，显示重新上架按钮
        self.changePrice.hidden = YES;
        self.soldOut.hidden = YES;
        self.stepView.hidden = YES;
        self.repeatOn.hidden = NO;
        //                CGRect frame = CGRectMake(0, CGRectGetMaxY(self.repeatOn.frame) + 20, YLScreenWidth, 100);
        //                [self.stepView setFrame:frame];
        self.numberView.frame = CGRectMake(0, CGRectGetMaxY(self.repeatOn.frame) + YLLeftMargin, YLScreenWidth, 30);
    } else {// d车辆未上架：待验车、待约定状态，不显示修改价格、上架、重新上架的按钮
        self.changePrice.hidden = YES;
        self.soldOut.hidden = YES;
        self.repeatOn.hidden = YES;
        self.stepView.hidden = NO;
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.command.frame) + 20, YLScreenWidth, 100);
        [self.stepView setFrame:frame];
        self.numberView.frame = CGRectMake(0, CGRectGetMaxY(self.stepView.frame), YLScreenWidth, 30);
    }
    
    if ([self.saleOrderModel.detail.status isEqualToString:@"0"]) { // 车辆下架状态，显示重新上架按钮
        self.stepView.stepIndex = 0;
    } else {
        // 根据订单状态修改进度条
        if ([self.saleOrderModel.status isEqualToString:@"1"]) {
            self.stepView.stepIndex = 0;
        } else if ([self.saleOrderModel.status isEqualToString:@"2"]) {
            self.stepView.stepIndex = 1;
        } else if ([self.saleOrderModel.status isEqualToString:@"3"]) {
            self.stepView.stepIndex = 2;
        } else {
            self.stepView.stepIndex = 3;
        }
    }
    
    self.numberView.tureNumber = self.saleOrderModel.detail.lookSum;
    self.numberView.browseNumber = self.saleOrderModel.detail.clickSum;
}

- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"即将看车下架数据保存成功");
    } else {
        NSLog(@"保存失败");
    }
}

- (void)setupUI {
    
    YLCommandView *command = [[YLCommandView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 110)];
//    command.model = self.model;
    command.saleOrderCommandBlock = ^(YLTableViewModel * _Nonnull model) {
        YLDetailController *detail = [[YLDetailController alloc] init];
        detail.model = model;
        [self.navigationController pushViewController:detail animated:YES];
    };
    [self.view addSubview:command];
    self.command = command;
    
    // 两个按钮根据状态而显示，如果没有上架，不显示，反之则显示
    CGFloat width = (YLScreenWidth - 2 * YLLeftMargin - 5) / 2;
    YLCondition *changePirce = [YLCondition buttonWithType:UIButtonTypeCustom];
    changePirce.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(command.frame) + 5, width, 40);
    [changePirce setTitle:@"修改价格" forState:UIControlStateNormal];
    changePirce.titleLabel.font = [UIFont systemFontOfSize:14];
    changePirce.type = YLConditionTypeWhite;
    [changePirce addTarget:self action:@selector(changePriceClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePirce];
    self.changePrice = changePirce;
    
    YLCondition *soldOut = [YLCondition buttonWithType:UIButtonTypeCustom];
    soldOut.frame = CGRectMake(CGRectGetMaxX(changePirce.frame) + 5, CGRectGetMaxY(command.frame) + 5, width, 40);
    [soldOut setTitle:@"下架" forState:UIControlStateNormal];
    soldOut.titleLabel.font = [UIFont systemFontOfSize:14];
    soldOut.type = YLConditionTypeWhite;
    [soldOut addTarget:self action:@selector(soldOutClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:soldOut];
    self.soldOut = soldOut;
    
    YLCondition *repeatOn = [YLCondition buttonWithType:UIButtonTypeCustom];
    repeatOn.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(command.frame) + 5, (YLScreenWidth - 2 * YLLeftMargin), 40);
    [repeatOn setTitle:@"重新上架" forState:UIControlStateNormal];
    repeatOn.titleLabel.font = [UIFont systemFontOfSize:14];
    repeatOn.type = YLConditionTypeBlue;
    [repeatOn addTarget:self action:@selector(repeatOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:repeatOn];
    self.repeatOn = repeatOn;

    NSArray *titles = @[@"待约定", @"待检测", @"售卖中", @"已完成"];// 根据订单状态而定
    CGRect frame = CGRectMake(0, CGRectGetMaxY(changePirce.frame) + 20, YLScreenWidth, 100);
    YLStepView *stepView = [[YLStepView alloc] initWithFrame:frame titles:titles];
//    stepView.stepIndex = 0;
    [self.view addSubview:stepView];
    self.stepView = stepView;
    
    YLLookCarNumberView *numberView = [[YLLookCarNumberView alloc] init];
//    numberView.frame = CGRectMake(0, CGRectGetMaxY(stepView.frame), YLScreenWidth, 30);
//    numberView.tureNumber = @"3";
//    numberView.browseNumber = @"432";
    //    numberView.backgroundColor = [UIColor redColor];
    [self.view addSubview:numberView];
    self.numberView = numberView;
    
    [self.view addSubview:self.cover];
    [self.cover addSubview:self.changePriceView];
}

- (void)repeatOnClick {
    NSLog(@"重新上架");
    NSString *urlString = @"http://ucarjava.bceapp.com/sell?method=handle";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.model.detail.carID forKey:@"detailId"];
    [param setValue:@"3" forKey:@"status"];
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSLog(@"上架成功:%@", responseObject[@"data"]);
            [self loadData];
            [self showMessage:@"上架成功"];
            if (self.saleDetailBlock) {
                self.saleDetailBlock();
            }
            
        } else {
            [self showMessage:@"上架失败"];
        }
    } failed:nil];
}

- (void)changePriceClick {
    NSLog(@"修改价格");
    self.cover.hidden = NO;
}

- (void)soldOutClick {
    NSLog(@"下架");
    NSString *urlString = @"http://ucarjava.bceapp.com/sell?method=handle";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.model.detail.carID forKey:@"detailId"];
//    [param setValue:self.model.examineTime forKey:@"examineTime"];
    [param setValue:@"0" forKey:@"status"];
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSLog(@"下架成功:%@", responseObject[@"data"]);
            [self loadData];
            [self showMessage:@"下架成功"];
            if (self.saleDetailBlock) {
                self.saleDetailBlock();
            }
        } else {
            [self showMessage:@"下架失败"];
        }
    } failed:nil];
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
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.changePriceView setFrame:CGRectMake(self.changePriceView.frame.origin.x, self.changePriceView.frame.origin.y + deltaY, self.changePriceView.frame.size.width, self.changePriceView.frame.size.height)];
    }];
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

- (YLChangePriceView *)changePriceView {
    if (!_changePriceView) {
        _changePriceView = [[YLChangePriceView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 214 - 64, YLScreenWidth, 214)];
        
        __weak typeof(self) weakSelf = self;
        _changePriceView.changePriceBlock = ^(NSInteger price, NSInteger floor, BOOL isAccept) {
            NSLog(@"price:%ld, floor:%ld, isAccept:%d", price, floor, isAccept);
            weakSelf.cover.hidden = YES;
            // 向后台发送修改价格请求
            NSString *urlString = @"http://ucarjava.bceapp.com/sell?method=change";
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:weakSelf.model.detail.carID forKey:@"detailId"];
            [param setValue:weakSelf.model.detail.price forKey:@"prePrice"];
            [param setValue:[NSString stringWithFormat:@"%ld", price] forKey:@"price"];
            [param setValue:[NSString stringWithFormat:@"%ld", floor] forKey:@"floorPrice"];
            [param setValue:[NSNumber numberWithBool:isAccept] forKey:@"isBargain"];
            
            [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
                if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                    NSLog(@"修改价格成功");
                    [weakSelf loadData];
                    [weakSelf showMessage:@"修改价格成功"];
                    if (weakSelf.saleDetailBlock) {
                        weakSelf.saleDetailBlock();
                    }
                    
                }
                if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
                    NSLog(@"修改价格失败");
                    [weakSelf showMessage:@"修改价格失败"];
                }
            } failed:nil];
        };
        
        _changePriceView.cancelBlock = ^{
            weakSelf.cover.hidden = YES;
        };
    }
    return _changePriceView;
}

- (void)setModel:(YLSaleOrderModel *)model {
    _model = model;

//    [self setupUI];
    
//    // 根据车辆状态修改显示修改价格、下架和重新上架的按钮还有进度条的位置
//    if ([model.detail.status isEqualToString:@"3"]) { // 车辆在售状态、显示修改价格、下架
//        self.changePrice.hidden = NO;
//        self.soldOut.hidden = NO;
//        self.repeatOn.hidden = YES;
//        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.changePrice.frame) + 20, YLScreenWidth, 100);
//        [self.stepView setFrame:frame];
//        self.numberView.frame = CGRectMake(0, CGRectGetMaxY(self.stepView.frame), YLScreenWidth, 30);
//    } else if ([model.detail.status isEqualToString:@"0"]) { // 车辆下架状态，显示重新上架按钮
//        self.changePrice.hidden = YES;
//        self.soldOut.hidden = YES;
//        self.repeatOn.hidden = NO;
//        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.repeatOn.frame) + 20, YLScreenWidth, 100);
//        [self.stepView setFrame:frame];
//        self.numberView.frame = CGRectMake(0, CGRectGetMaxY(self.stepView.frame), YLScreenWidth, 30);
//    } else {// d车辆未上架：待验车、待约定状态，不显示修改价格、上架、重新上架的按钮
//        self.changePrice.hidden = YES;
//        self.soldOut.hidden = YES;
//        self.repeatOn.hidden = YES;
//        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.command.frame) + 20, YLScreenWidth, 100);
//        [self.stepView setFrame:frame];
//        self.numberView.frame = CGRectMake(0, CGRectGetMaxY(self.stepView.frame), YLScreenWidth, 30);
//    }
//
//    if ([model.detail.status isEqualToString:@"0"]) { // 车辆下架状态，显示重新上架按钮
//
//    } else {
//        // 根据订单状态修改进度条
//        if ([model.status isEqualToString:@"1"]) {
//            self.stepView.stepIndex = 0;
//        } else if ([model.status isEqualToString:@"2"]) {
//            self.stepView.stepIndex = 1;
//        } else if ([model.status isEqualToString:@"3"]) {
//            self.stepView.stepIndex = 2;
//        } else {
//            self.stepView.stepIndex = 3;
//        }
//    }
//
//    self.numberView.tureNumber = model.detail.lookSum;
//    self.numberView.browseNumber = model.detail.clickSum;
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

@end

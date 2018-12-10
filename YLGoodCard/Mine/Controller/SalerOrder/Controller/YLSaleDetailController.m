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

@interface YLSaleDetailController ()

@property (nonatomic, strong) UIView *cover;
@property (nonatomic, strong) YLChangePriceView *changePriceView;
@property (nonatomic, strong) YLCondition *changePrice;
@property (nonatomic, strong) YLCondition *soldOut;
@property (nonatomic, strong) YLStepView *stepView;
@property (nonatomic, strong) YLCommandView *command;
@property (nonatomic, strong) YLLookCarNumberView *numberView;

@end

@implementation YLSaleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"卖车订单详情";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transformView:) name:@"UIKeyboardWillChangeFrameNotification" object:nil];
}

- (void)setupUI {
    
    YLCommandView *command = [[YLCommandView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, 110)];
    command.model = self.model;
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
    
    NSArray *titles = @[@"待约定", @"待检测", @"售卖中", @"已完成", @"已取消"];// 根据订单状态而定
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


- (void)changePriceClick {
    NSLog(@"修改价格");
    self.cover.hidden = NO;
}

- (void)soldOutClick {
    NSLog(@"下架");
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
        _cover = [[UIView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, YLScreenHeight)];
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
                }
                if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
                    NSLog(@"修改价格失败");
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

    [self setupUI];
    
    if ([model.detail.status isEqualToString:@"3"]) {
        self.changePrice.hidden = NO;
        self.soldOut.hidden = NO;
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.changePrice.frame) + 20, YLScreenWidth, 100);
        [self.stepView setFrame:frame];
        self.numberView.frame = CGRectMake(0, CGRectGetMaxY(self.stepView.frame), YLScreenWidth, 30);
    } else {
        self.changePrice.hidden = YES;
        self.soldOut.hidden = YES;
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.command.frame) + 20, YLScreenWidth, 100);
        [self.stepView setFrame:frame];
        self.numberView.frame = CGRectMake(0, CGRectGetMaxY(self.stepView.frame), YLScreenWidth, 30);
    }
    
    if ([model.status isEqualToString:@"1"]) {
        self.stepView.stepIndex = 0;
    } else if ([model.status isEqualToString:@"2"]) {
        self.stepView.stepIndex = 1;
    } else if ([model.status isEqualToString:@"3"]) {
        self.stepView.stepIndex = 2;
    } else if ([model.status isEqualToString:@"4"]) {
        self.stepView.stepIndex = 3;
    } else {
        self.stepView.stepIndex = 4;
    }
    
    self.numberView.tureNumber = model.detail.lookSum;
    self.numberView.browseNumber = model.detail.clickSum;
}

@end

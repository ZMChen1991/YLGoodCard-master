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

@interface YLSaleDetailController ()

@property (nonatomic, strong) UIView *cover;
@property (nonatomic, strong) YLChangePriceView *changePriceView;

@end

@implementation YLSaleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"卖车订单详情";
    
    [self setupUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transformView:) name:@"UIKeyboardWillChangeFrameNotification" object:nil];
}

- (void)setupUI {
    
    YLCommandView *command = [[YLCommandView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, 110)];
    [self.view addSubview:command];
    
    CGFloat width = (YLScreenWidth - 2 * YLLeftMargin - 5) / 2;
    YLCondition *changePirce = [YLCondition buttonWithType:UIButtonTypeCustom];
    changePirce.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(command.frame) + 5, width, 40);
    [changePirce setTitle:@"修改价格" forState:UIControlStateNormal];
    changePirce.type = YLConditionTypeWhite;
    [changePirce addTarget:self action:@selector(changePrice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePirce];
    
    YLCondition *soldOut = [YLCondition buttonWithType:UIButtonTypeCustom];
    soldOut.frame = CGRectMake(CGRectGetMaxX(changePirce.frame) + 5, CGRectGetMaxY(command.frame) + 5, width, 40);
    [soldOut setTitle:@"下架" forState:UIControlStateNormal];
    soldOut.type = YLConditionTypeWhite;
    [soldOut addTarget:self action:@selector(soldOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:soldOut];
    
    NSArray *titles = @[@"待检测", @"售卖中", @"已完成"];
    CGRect frame = CGRectMake(0, CGRectGetMaxY(changePirce.frame) + 40, YLScreenWidth, 100);
    YLStepView *stepView = [[YLStepView alloc] initWithFrame:frame titles:titles];
    stepView.stepIndex = 1;
    //    stepView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:stepView];
    
    YLLookCarNumberView *numberView = [[YLLookCarNumberView alloc] init];
    numberView.frame = CGRectMake(0, CGRectGetMaxY(stepView.frame), YLScreenWidth, 30);
    numberView.tureNumber = @"3";
    numberView.browseNumber = @"432";
    //    numberView.backgroundColor = [UIColor redColor];
    [self.view addSubview:numberView];
    
    [self.view addSubview:self.cover];
    [self.cover addSubview:self.changePriceView];
}

- (void)changePrice {
    NSLog(@"修改价格");
    self.cover.hidden = NO;
}

- (void)soldOut {
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
        _changePriceView.changePriceBlock = ^(NSString * _Nonnull price, NSString * _Nonnull floor, BOOL isAccept) {
            NSLog(@"价格：%@,底价:%@,是否接受议价：%d", price, floor, isAccept);
            weakSelf.cover.hidden = YES;
        };
        
        _changePriceView.cancelBlock = ^{
            weakSelf.cover.hidden = YES;
        };
    }
    return _changePriceView;
}

@end

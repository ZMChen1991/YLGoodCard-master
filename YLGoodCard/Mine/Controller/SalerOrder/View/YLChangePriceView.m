//
//  YLChangePriceView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLChangePriceView.h"
#import "YLCondition.h"

@interface YLChangePriceView ()

@property (nonatomic, strong) UITextField *changePrice;// 卖车价格
@property (nonatomic, strong) UITextField *changeFloor;// 卖车底价
@property (nonatomic, strong) UIButton *acceptBtn;
@property (nonatomic, strong) UIButton *refuseBtn;

@property (nonatomic, assign) BOOL isAccept;// 是否接受议价

@end

@implementation YLChangePriceView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CGFloat labelW = 120;
    CGFloat labelH = 30;
    
    UILabel *changePriceL = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, labelW, labelH)];
    changePriceL.text = @"修改卖车价格";
    [self addSubview:changePriceL];
    
    UILabel *changeFloorL = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(changePriceL.frame) + 20, labelW, labelH)];
    changeFloorL.text = @"修改卖车底价";
    [self addSubview:changeFloorL];
    
    CGFloat textW = YLScreenWidth - CGRectGetMaxX(changePriceL.frame) - 30 - 20;
    CGFloat textH = 30;
    UITextField *changePrice = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changePriceL.frame) + 20, 20, textW, textH)];
    changePrice.placeholder = @"请输入卖车价格:";
    changePrice.layer.borderWidth = 0.5;
    changePrice.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    [self addSubview:changePrice];
    self.changePrice = changePrice;
    
    UITextField *changeFloor = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changePriceL.frame) + 20, CGRectGetMaxY(changePrice.frame) + 20, textW, textH)];
    changeFloor.placeholder = @"请输入卖车底价:";
    changeFloor.layer.borderWidth = 0.5;
    changeFloor.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    [self addSubview:changeFloor];
    self.changeFloor = changeFloor;
    
    UIButton *accept = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(changeFloor.frame) + 23, 16, 16)];
    [accept addTarget:self action:@selector(accept) forControlEvents:UIControlEventTouchUpInside];
    accept.backgroundColor = [UIColor redColor];
    [self addSubview:accept];
    self.acceptBtn = accept;
    
    UILabel *acceptLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accept.frame) + 15, CGRectGetMaxY(changeFloor.frame) + 20, (YLScreenWidth / 2) - CGRectGetMaxX(accept.frame) - 15, 22)];
    acceptLabel.text = @"接受议价";
    [self addSubview:acceptLabel];
    
    UIButton *refuse = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(acceptLabel.frame), CGRectGetMaxY(changeFloor.frame) + 23, 16, 16)];
    [refuse addTarget:self action:@selector(refuse) forControlEvents:UIControlEventTouchUpInside];
    refuse.backgroundColor = [UIColor greenColor];
    [self addSubview:refuse];
    self.refuseBtn = refuse;
    
    UILabel *refuseLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(refuse.frame) + 20, CGRectGetMaxY(changeFloor.frame) + 20, (YLScreenWidth / 2) - CGRectGetMaxX(accept.frame) - 15, 22)];
    refuseLabel.text = @"不接受议价";
    [self addSubview:refuseLabel];
    
    CGFloat btnW = (YLScreenWidth - 2 * YLLeftMargin - 10) / 2;
    YLCondition *cancel = [YLCondition buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(acceptLabel.frame) + YLLeftMargin, btnW, 40);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.type = YLConditionTypeWhite;
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    
    YLCondition *ensure = [YLCondition buttonWithType:UIButtonTypeCustom];
    ensure.frame = CGRectMake(CGRectGetMaxX(cancel.frame) + 10, CGRectGetMaxY(acceptLabel.frame) + YLLeftMargin, btnW, 40);
    [ensure setTitle:@"确定" forState:UIControlStateNormal];
    ensure.type = YLConditionTypeBlue;
    [ensure addTarget:self action:@selector(ensure) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ensure];
    
}

- (void)ensure {
    
    NSLog(@"点击了确定按钮");
    [self.changePrice resignFirstResponder];
    [self.changeFloor resignFirstResponder];
    if (self.changePriceBlock) {
        self.changePriceBlock(self.changePrice.text, self.changeFloor.text, self.isAccept);
    }
}

- (void)cancel {
    NSLog(@"点击了取消按钮");
    [self.changePrice resignFirstResponder];
    [self.changeFloor resignFirstResponder];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)accept {
    NSLog(@"接受议价");
    self.isAccept = YES;
    // 这里改变按钮的背景图片
}
- (void)refuse {
    NSLog(@"不接受议价");
    self.isAccept = NO;
    // 这里改变按钮的背景图片
}
@end

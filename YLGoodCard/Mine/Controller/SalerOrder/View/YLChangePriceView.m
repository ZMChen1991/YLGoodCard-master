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
    
    CGFloat labelW = 150;
    CGFloat labelH = 30;
    
    UILabel *changePriceL = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, labelW, labelH)];
    changePriceL.text = @"修改卖车价格(万):";
    changePriceL.font = [UIFont systemFontOfSize:14];
    [self addSubview:changePriceL];
    
    UILabel *changeFloorL = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(changePriceL.frame) + 20, labelW, labelH)];
    changeFloorL.text = @"修改卖车底价(万):";
    changeFloorL.font = [UIFont systemFontOfSize:14];
    [self addSubview:changeFloorL];
    
    CGFloat textW = YLScreenWidth - CGRectGetMaxX(changePriceL.frame) - 30 - 20;
    CGFloat textH = 30;
    UITextField *changePrice = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changePriceL.frame) + 20, 20, textW, textH)];
    changePrice.placeholder = @"请输入卖车价格";
    changePrice.font = [UIFont systemFontOfSize:14];
    changePrice.layer.borderWidth = 0.5;
    changePrice.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    [self addSubview:changePrice];
    self.changePrice = changePrice;
    
    UITextField *changeFloor = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changePriceL.frame) + 20, CGRectGetMaxY(changePrice.frame) + 20, textW, textH)];
    changeFloor.placeholder = @"请输入卖车底价";
    changeFloor.font = [UIFont systemFontOfSize:14];
    changeFloor.layer.borderWidth = 0.5;
    changeFloor.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    [self addSubview:changeFloor];
    self.changeFloor = changeFloor;
    
    // 默认接受议价
    UIButton *accept = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(changeFloor.frame) + 23, 16, 16)];
    [accept addTarget:self action:@selector(accept) forControlEvents:UIControlEventTouchUpInside];
    accept.backgroundColor = YLColor(8.f, 169.f, 255.f);
    accept.layer.borderWidth = 1.f;
    accept.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    accept.layer.cornerRadius = 8.f;
    accept.layer.masksToBounds = YES;
    [self addSubview:accept];
    self.acceptBtn = accept;
    
    UILabel *acceptLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accept.frame) + 15, CGRectGetMaxY(changeFloor.frame) + 20, (YLScreenWidth / 2) - CGRectGetMaxX(accept.frame) - 15, 22)];
    acceptLabel.text = @"接受议价";
    acceptLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:acceptLabel];
    
    UIButton *refuse = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(acceptLabel.frame), CGRectGetMaxY(changeFloor.frame) + 23, 16, 16)];
    [refuse addTarget:self action:@selector(refuse) forControlEvents:UIControlEventTouchUpInside];
    refuse.backgroundColor = [UIColor whiteColor];
    refuse.layer.borderWidth = 1.f;
    refuse.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    refuse.layer.cornerRadius = 8.f;
    refuse.layer.masksToBounds = YES;
    [self addSubview:refuse];
    self.refuseBtn = refuse;
    
    UILabel *refuseLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(refuse.frame) + 20, CGRectGetMaxY(changeFloor.frame) + 20, (YLScreenWidth / 2) - CGRectGetMaxX(accept.frame) - 15, 22)];
    refuseLabel.text = @"不接受议价";
    refuseLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:refuseLabel];
    
    CGFloat btnW = (YLScreenWidth - 2 * YLLeftMargin - 10) / 2;
    YLCondition *cancel = [YLCondition buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(acceptLabel.frame) + YLLeftMargin, btnW, 40);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:14];
    cancel.type = YLConditionTypeWhite;
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    
    YLCondition *ensure = [YLCondition buttonWithType:UIButtonTypeCustom];
    ensure.frame = CGRectMake(CGRectGetMaxX(cancel.frame) + 10, CGRectGetMaxY(acceptLabel.frame) + YLLeftMargin, btnW, 40);
    ensure.titleLabel.font = [UIFont systemFontOfSize:14];
    [ensure setTitle:@"确定" forState:UIControlStateNormal];
    ensure.type = YLConditionTypeBlue;
    [ensure addTarget:self action:@selector(ensure) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ensure];
    
}

- (void)ensure {
    
    NSLog(@"点击了确定按钮");
    [self.changePrice resignFirstResponder];
    [self.changeFloor resignFirstResponder];
    if ([self isBlankString:self.changePrice.text]) {
        NSLog(@"请输入要修改的价格");
        [self showMessage:@"请输入要修改的价格"];
    } else {
        if (self.changePriceBlock) {
            NSInteger changePrice = [self.changePrice.text integerValue] * 10000;
            NSInteger changeFloor = [self.changeFloor.text integerValue] * 10000;
            self.changePriceBlock(changePrice, changeFloor, self.isAccept);
        }
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
    self.acceptBtn.backgroundColor = YLColor(8.f, 169.f, 255.f);
    self.refuseBtn.backgroundColor = [UIColor whiteColor];
}
- (void)refuse {
    NSLog(@"不接受议价");
    self.isAccept = NO;
    // 这里改变按钮的背景图片
    self.acceptBtn.backgroundColor = [UIColor whiteColor];
    self.refuseBtn.backgroundColor = YLColor(8.f, 169.f, 255.f);
}

// 判断字符串是否为空或者空格符
-  (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
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

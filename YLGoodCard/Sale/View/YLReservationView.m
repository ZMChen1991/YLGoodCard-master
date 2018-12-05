//
//  YLReservationView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLReservationView.h"
#import "YLCondition.h"

@interface YLReservationView ()

@property (nonatomic, strong) UILabel *centerName;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *tel;
@property (nonatomic, strong) UILabel *time;

@end

@implementation YLReservationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"成功"];
    icon.frame = CGRectMake(YLScreenWidth / 2 - 25, 75, 50, 50);
    [self addSubview:icon];
    
    UILabel *success = [[UILabel alloc] init];
    success.text = @"恭喜您预约成功";
    success.font = [UIFont systemFontOfSize:20];
    success.textColor = YLColor(8.f, 169.f, 255.f);
    success.textAlignment = NSTextAlignmentCenter;
    success.frame = CGRectMake(0, CGRectGetMaxY(icon.frame) + 10, YLScreenWidth, 28);
    [self addSubview:success];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(success.frame) + 20, YLScreenWidth - 2 * YLLeftMargin, 162)];
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = YLColor(213.f, 213.f, 213.f).CGColor;
    [self addSubview:view];
    
    CGFloat width = view.frame.size.width;
    UILabel *title = [[UILabel alloc] init];
    title.text = @"预约信息";
    title.font = [UIFont systemFontOfSize:16];
    title.frame = CGRectMake(YLLeftMargin, YLLeftMargin, width - 2 * YLLeftMargin, 22);
    [view addSubview:title];
    // 后面的信息d到时候获取直接拼接
    UILabel *centerName = [[UILabel alloc] init];
    centerName.text = @"监测中心:";
    centerName.font = [UIFont systemFontOfSize:14];
    centerName.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(title.frame) + YLLeftMargin, 70, 20);
    [view addSubview:centerName];
    
    UILabel *cent = [[UILabel alloc] init];
    cent.font = [UIFont systemFontOfSize:14];
    cent.frame = CGRectMake(CGRectGetMaxX(centerName.frame), CGRectGetMaxY(title.frame) + YLLeftMargin, width - 2 * YLLeftMargin - 70, 20);
    cent.textAlignment = NSTextAlignmentLeft;
    [view addSubview:cent];
    self.centerName = cent;
    
    UILabel *address = [[UILabel alloc] init];
    address.text = @"检测地址:";
    address.font = [UIFont systemFontOfSize:14];
    address.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(centerName.frame) + 5, 70, 20);
    [view addSubview:address];
    
    UILabel *addr = [[UILabel alloc] init];
    addr.font = [UIFont systemFontOfSize:14];
    addr.textAlignment = NSTextAlignmentLeft;
    addr.frame = CGRectMake(CGRectGetMaxX(address.frame), CGRectGetMaxY(centerName.frame) + 5, width - 2 * YLLeftMargin - 70, 20);
    [view addSubview:addr];
    self.address = addr;
    
    UILabel *tel = [[UILabel alloc] init];
    tel.text = @"联系电话:";
    tel.font = [UIFont systemFontOfSize:14];
    tel.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(address.frame) + 5, 70, 20);
    [view addSubview:tel];
    UILabel *telephone = [[UILabel alloc] init];
    telephone.font = [UIFont systemFontOfSize:14];
    telephone.textAlignment = NSTextAlignmentLeft;
    telephone.frame = CGRectMake(CGRectGetMaxX(tel.frame), CGRectGetMaxY(address.frame) + 5, width - 2 * YLLeftMargin - 70, 20);
    [view addSubview:telephone];
    self.tel = telephone;
    
    UILabel *time = [[UILabel alloc] init];
    time.text = @"验车时间:";
    time.font = [UIFont systemFontOfSize:14];
    time.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(tel.frame) + 5, 70, 20);
    [view addSubview:time];
    UILabel *checkOut = [[UILabel alloc] init];
    checkOut.font = [UIFont systemFontOfSize:14];
    checkOut.textAlignment = NSTextAlignmentLeft;
    checkOut.frame = CGRectMake(CGRectGetMaxX(time.frame), CGRectGetMaxY(tel.frame) + 5, width - 2 * YLLeftMargin - 70, 20);
    [view addSubview:checkOut];
    self.time = checkOut;
    
    YLCondition *contact = [YLCondition buttonWithType:UIButtonTypeCustom];
    contact.type = YLConditionTypeWhite;
    contact.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(view.frame) + 20, (width - 5) / 2, 40);
    [contact setTitle:@"现在联系" forState:UIControlStateNormal];
    [contact addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:contact];
    
    YLCondition *complete = [YLCondition buttonWithType:UIButtonTypeCustom];
    complete.type = YLConditionTypeBlue;
    complete.frame = CGRectMake(CGRectGetMaxX(contact.frame) + 5, CGRectGetMaxY(view.frame) + 20, (width - 5) / 2, 40);
    [complete setTitle:@"完成" forState:UIControlStateNormal];
    [complete addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:complete];
    
}

- (void)contact {
    
    NSLog(@"点击了现在联系按钮");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"联系电话" message:@"0662-888888888" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)complete {
    
    NSLog(@"点击了完成按钮");
    // 跳转到首页或者其他界面
    if (self.reserVationBlock) {
        self.reserVationBlock();
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

- (void)setModel:(YLDetectCenterModel *)model {
    
    _model = model;
    self.centerName.text = model.name;
    self.address.text = model.address;
    self.tel.text = model.phone;
}

- (void)setCheckOut:(NSString *)checkOut {
    
    _checkOut = checkOut;
    self.time.text = checkOut;
}

@end

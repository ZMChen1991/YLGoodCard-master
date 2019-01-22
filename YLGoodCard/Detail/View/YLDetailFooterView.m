//
//  YLDetailFooterView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailFooterView.h"
#import "YLAccount.h"
#import "YLAccountTool.h"


@interface YLDetailFooterView ()

@property (nonatomic, strong) UIButton *favorite;
@property (nonatomic, strong) UIButton *customer;

@property (nonatomic, strong) YLAccount *account;

@end

@implementation YLDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
//        self.isCollect = NO;
    }
    return self;
}

- (void)setupUI {
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 1)];
    line.backgroundColor = YLColor( 233.f, 233.f, 233.f);
    [self addSubview:line];
    
    self.customer = [UIButton buttonWithType:UIButtonTypeCustom];
    self.customer.tag = 100 + 2;
    [self.customer setImage:[UIImage imageNamed:@"客服"] forState:UIControlStateNormal];
    [self.customer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.customer.frame = CGRectMake(YLLeftMargin, YLTopMargin, 30, self.frame.size.height - 2 * YLTopMargin);
//    self.customer.frame = CGRectMake(CGRectGetMaxX(self.favorite.frame) + 5, YLTopMargin, 27, self.frame.size.height - 2 * YLTopMargin);
    [self.customer addTarget:self action:@selector(clickCustomer:) forControlEvents:UIControlEventTouchUpInside];
    
    self.favorite = [UIButton buttonWithType:UIButtonTypeCustom];
    self.favorite.tag = 100 + 1;
    [self.favorite setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    self.favorite.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.favorite setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.favorite.frame = CGRectMake(YLLeftMargin, YLTopMargin, 30, self.frame.size.height - 2 * YLTopMargin);
    self.favorite.frame = CGRectMake(CGRectGetMaxX(self.customer.frame) + 10, YLTopMargin, 35, self.frame.size.height - 2 * YLTopMargin);
    [self.favorite addTarget:self action:@selector(clickFavorite:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat btnW = YLScreenWidth - CGRectGetMaxX(self.favorite.frame) - 2 * YLLeftMargin - 10;
    self.bargain = [YLCondition buttonWithType:UIButtonTypeCustom];
    [self.bargain setTitle:@"砍价" forState:UIControlStateNormal];
    self.bargain.type = YLConditionTypeWhite;
    self.bargain.titleLabel.font = [UIFont systemFontOfSize:14];
    self.bargain.frame = CGRectMake(CGRectGetMaxX(self.favorite.frame) + YLLeftMargin, YLTopMargin, btnW / 2, self.frame.size.height - 2 * YLTopMargin);
//    [self.bargain addTarget:self action:@selector(clickBargain) forControlEvents:UIControlEventTouchUpInside];
    
    self.order = [YLCondition buttonWithType:UIButtonTypeCustom];
    [self.order setTitle:@"预约看车" forState:UIControlStateNormal];
    self.order.type = YLConditionTypeBlue;
    self.order.titleLabel.font = [UIFont systemFontOfSize:14];
    self.order.frame = CGRectMake(CGRectGetMaxX(self.bargain.frame) + 10, YLTopMargin, btnW / 2, self.frame.size.height - 2 * YLTopMargin);
//    [self.order addTarget:self action:@selector(clickOrder) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.favorite];
    [self addSubview:self.customer];
    [self addSubview:self.bargain];
    [self addSubview:self.order];
}

- (void)clickFavorite:(UIButton *)sender {
//    NSLog(@"favorite");
    // 这里要判断用户是否登录
    if (self.account) {
        if ([self.isCollect isEqualToString:@"1"]) {
            self.isCollect = @"0";
            NSLog(@"取消收藏");
            [self.favorite setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
        } else {
            self.isCollect = @"1";
            NSLog(@"收藏");
            [self.favorite setImage:[UIImage imageNamed:@"已收藏"] forState:UIControlStateNormal];
        }
    }  else {
        NSLog(@"用户没有登录，不能收藏");
        [self.favorite setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    }
    if (self.collectBlock) {
        self.collectBlock(self.isCollect);
    }
}

- (void)clickCustomer:(UIButton *)sender {
    NSLog(@"customer");
    if (self.customBlock) {
        self.customBlock();
    }
}

- (void)clickBargain {
    NSLog(@"bargain");
}

- (void)clickOrder {
    NSLog(@"order");
}

- (void)setModel:(YLDetailModel *)model {
    
    _model = model;
//    if (model.isCollect) {
//        [self.favorite setImage:[UIImage imageNamed:@"已收藏"] forState:UIControlStateNormal];
//    } else {
//        [self.favorite setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
//    }
//
//    if (model.isBook) {
//        [self.order setTitle:@"已预约" forState:UIControlStateNormal];
//        [self.order setUserInteractionEnabled:NO];
//    } else {
//
//    }
}

- (void)setIsBook:(NSString *)isBook {
    _isBook = isBook;
    if ([isBook isEqualToString:@"0"]) { // 没有预约看车
        [self.order setTitle:@"预约看车" forState:UIControlStateNormal];
    } else { // 已预约
        [self.order setTitle:@"已预约" forState:UIControlStateNormal];
        [self.order setUserInteractionEnabled:NO];

    }
}
- (void)setIsCollect:(NSString *)isCollect {
    _isCollect = isCollect;
    if ([isCollect isEqualToString:@"0"]) { // 没有收藏
        [self.favorite setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    } else { // 已收藏
        [self.favorite setImage:[UIImage imageNamed:@"已收藏"] forState:UIControlStateNormal];
    }
}

- (YLAccount *)account {
    if (!_account) {
        _account = [YLAccountTool account];
    }
    return _account;
}

@end

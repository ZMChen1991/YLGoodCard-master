//
//  YLCompleteView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCompleteView.h"
#import "YLCondition.h"

@implementation YLCompleteView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UILabel *success = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 28)];
    success.textAlignment = NSTextAlignmentCenter;
    success.text = @"恭喜您购买成功";
    success.textColor = YLColor(8.f, 169.f, 255.f);
    success.font = [UIFont systemFontOfSize:20];
    [self addSubview:success];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(success.frame) + 5, YLScreenWidth, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"如有任何疑问或者售后需求，请联系我们的客服";
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    YLCondition *contact = [YLCondition buttonWithType:UIButtonTypeCustom];
    contact.type = YLConditionTypeBlue;
    contact.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(label.frame) + 20, YLScreenWidth - 2 * YLLeftMargin, 40);
    [contact setTitle:@"联系客服" forState:UIControlStateNormal];
    [contact addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:contact];
    
}

- (void)contact {
    NSLog(@"点击联系客服");
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}
@end

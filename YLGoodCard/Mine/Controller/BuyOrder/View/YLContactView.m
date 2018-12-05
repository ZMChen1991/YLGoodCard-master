//
//  YLContactView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLContactView.h"
#import "YLCondition.h"

//@interface YLContactView ()
//
//
//
//@end

@implementation YLContactView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, YLScreenWidth, 20)];
    label.text = @"合同已签署，正在等待复检过户...";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
    
    YLCondition *contact = [YLCondition buttonWithType:UIButtonTypeCustom];
    contact.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(label.frame) + 20, YLScreenWidth - 2 *YLLeftMargin, 40);
    [contact setTitle:@"联系检测中心" forState:UIControlStateNormal];
    contact.type = YLConditionTypeBlue;
    [contact addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:contact];
}

- (void)contact {
    NSLog(@"点击联系检测中心");
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}


@end

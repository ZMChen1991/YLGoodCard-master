//
//  YLFunctionView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLFunctionView.h"
#import "YLCustomButton.h"
//#import "YLNumberView.h"

@interface YLFunctionView ()

@property (nonatomic, strong) NSMutableArray *function1; // 存放即将看车、我的收藏、浏览记录、我的订阅
@property (nonatomic, strong) NSMutableArray *function2; // 存放买车订单、卖车订单、砍价记录、降价提醒

@end

@implementation YLFunctionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    
    NSArray *array = @[@"即将看车", @"我的收藏", @"浏览记录", @"我的订阅"];
    
    NSArray *btnArray = @[@"卖车订单", @"买车订单", @"砍价记录", @"降价提醒"];
    NSArray *images = @[@"卖车订单", @"买车订单", @"砍价记录", @"降价提醒"];
 
    for (NSInteger i = 0; i < array.count; i++) {
        CGFloat width = self.frame.size.width / 4;
        CGFloat height = 88;
        YLNumberView *numberView = [[YLNumberView alloc] init];
        numberView.frame = CGRectMake(width * i, 0, width, height);
        numberView.number = self.numbers[i];
        numberView.title = array[i];
        numberView.tag = 200 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(numberViewClick:)];
        [numberView addGestureRecognizer:tap];
        [self addSubview:numberView];
        [self.function2 addObject:numberView];
    }
    
    for (NSInteger i = 0; i < btnArray.count; i++) {
        YLCustomButton *btn = [YLCustomButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:btnArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.function1 addObject:btn];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 176, self.frame.size.width, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
}

- (void)btnClick:(UIButton *)sender {
    
    NSLog(@"YLFunctionView:%ld", (long)sender.tag);
    if (self.delegate && [self.delegate respondsToSelector:@selector(btnClickToController:)]) {
        [self.delegate btnClickToController:sender];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSInteger count1 = [self.function1 count];
    NSInteger width = self.frame.size.width / 4;
    NSInteger height = 88;
    
    for (NSInteger i = 0; i < count1; i++) {
        UIButton *btn = self.function1[i];
        btn.frame = CGRectMake(width * i, height, width, height);
    }
}

- (void)numberViewClick:(UITapGestureRecognizer *)tap {
    
    NSInteger index = tap.view.tag - 200;
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberViewClickInIndex:)]) {
        [self.delegate numberViewClickInIndex:index];
    }
}

#pragma mark 懒加载
- (NSMutableArray *)function1 {
    
    if (!_function1) {
        _function1 = [NSMutableArray array];
    }
    return _function1;
}
- (NSMutableArray *)function2 {
    
    if (!_function2) {
        _function2 = [NSMutableArray array];
    }
    return _function2;
}
- (void)setNumbers:(NSMutableArray *)numbers {
    _numbers = numbers;
    NSInteger count = self.function2.count;
    for (NSInteger i = 0; i < count; i++) {
        YLNumberView *numberView = self.function2[i];
        numberView.number = numbers[i];
    }
}

@end

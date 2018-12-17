//
//  YLChoiceView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/17.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLChoiceView.h"
#import "YLCondition.h"

@interface YLChoiceView ()

@property (nonatomic, strong) YLCondition *btn;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) BOOL isSelect;

@end

@implementation YLChoiceView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        YLCondition *btn = [YLCondition buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 12, 12);
        btn.type = YLConditionTypeGray;
        [btn addTarget:self action:@selector(choiceBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        self.btn = btn;
        
        UILabel *label = [[UILabel alloc] init];
        label.text = title;
        [self addSubview:label];
        self.label = label;
        
        self.isSelect = NO;
    }
    return self;
}

- (void)choiceBtn {
 
    if (self.isSelect) {
        self.btn.type = YLConditionTypeBlue;
        if (self.choiceQuestionlock) {
            self.choiceQuestionlock(self.label.text);
        }
    } else {
        self.btn.type = YLConditionTypeGray;
    }
}
@end

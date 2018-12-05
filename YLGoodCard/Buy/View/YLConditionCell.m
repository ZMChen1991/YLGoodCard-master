//
//  YLConditionCell.m
//  HomeCollectionView
//
//  Created by lm on 2018/11/10.
//  Copyright © 2018 CocaCola. All rights reserved.
//

#import "YLConditionCell.h"
#import "YLCondition.h"

@interface YLConditionCell ()

@property (nonatomic, strong) YLCondition *btn;

@property (nonatomic, assign) BOOL isSelect;

@end


@implementation YLConditionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.btn = [[YLCondition alloc] initWithFrame:self.bounds];
        self.btn.type = YLConditionTypeGray;
        self.btn.titleLabel.font = [UIFont systemFontOfSize:12];
        self.btn.titleLabel.textColor = [UIColor blackColor];
        [self.btn setTitle:@"排量" forState:UIControlStateNormal];
        [self.btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
//        self.backgroundColor = [UIColor redColor];
        self.isSelect = NO;
    }
    return self;
    
}

- (void)click {
    NSLog(@"YLConditionCell:click");
    self.isSelect = !self.isSelect;
    if (self.isSelect) {
        self.btn.type = YLConditionTypeWhite;
    } else {
        self.btn.type = YLConditionTypeGray;
    }
    
}

@end

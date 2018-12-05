//
//  YLSaleStatusView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSaleStatusView.h"

@interface YLSaleStatusView ()

@property (nonatomic, strong) UILabel *lookCarNumer;// 实际看车
@property (nonatomic, strong) UILabel *browseNumber;// 浏览次数

@end

@implementation YLSaleStatusView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIView *view = [[UIView alloc] init];
    [self addSubview:view];
    UILabel *detection = [UILabel alloc];
    detection.text = @"待检测";
    [self addSubview:detection];
    
    UIView *view1 = [[UIView alloc] init];
    [self addSubview:view1];
    UILabel *saling = [UILabel alloc];
    saling.text = @"售卖中";
    [self addSubview:saling];
    
    UIView *view2 = [[UIView alloc] init];
    [self addSubview:view2];
    UILabel *complete = [UILabel alloc];
    complete.text = @"已完成";
    [self addSubview:complete];
    
    UIView *view3 = [[UIView alloc] init];
    [self addSubview:view3];
    
    UIView *view4 = [[UIView alloc] init];
    [self addSubview:view4];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"实际看车(次):";
    [self addSubview:label];
    
    UILabel *lookCarNumer = [[UILabel alloc] init];
    [self addSubview:lookCarNumer];
    self.lookCarNumer = lookCarNumer;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"浏览次数(次):";
    [self addSubview:label1];
    
    UILabel *browseNumber = [[UILabel alloc] init];
    [self addSubview:browseNumber];
    self.browseNumber = browseNumber;
    
}

- (void)setModel:(NSString *)model {
    
    _model = model;
    // 状态、 看车人数、浏览次数
    
}

@end

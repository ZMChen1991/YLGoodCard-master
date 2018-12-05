//
//  YLNumberView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/27.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLNumberView.h"

@interface YLNumberView ()

@property (nonatomic, strong) UILabel *numberL;
@property (nonatomic, strong) UILabel *titleL;

@end

@implementation YLNumberView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick:)];
//        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupUI {
    
//    CGFloat width = self.frame.size.width;
//    CGFloat height = self.frame.size.height;
//
    UILabel *numberLabel = [[UILabel alloc] init];
//    numberLabel.frame = CGRectMake(0, 10, width, height * 0.5);
    numberLabel.font = [UIFont systemFontOfSize:20];
    numberLabel.text = @"0";
    numberLabel.textColor = [UIColor blackColor];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:numberLabel];
    self.numberL = numberLabel;
//    numberLabel.backgroundColor = [UIColor redColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.frame = CGRectMake(0, CGRectGetMaxY(numberLabel.frame), width, height * 0.3);
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.text = @"xxx";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    self.titleL = titleLabel;
//    titleLabel.backgroundColor = [UIColor greenColor];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.numberL.frame = CGRectMake(0, 10, width, height * 0.5);
    self.titleL.frame = CGRectMake(0, CGRectGetMaxY(self.numberL.frame), width, height * 0.3);
}

//- (void)viewClick:(UIGestureRecognizer *)tap {
//    NSLog(@"点击了视图");
//    if (self.numberBlock) {
//        self.numberBlock();
//    }
//}

- (void)setNumber:(NSString *)number {
    _number = number;
    self.numberL.text = [NSString stringWithFormat:@"%@", number];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleL.text = title;
}

@end

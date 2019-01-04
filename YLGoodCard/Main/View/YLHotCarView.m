//
//  YLHotCarView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLHotCarView.h"
#import "YLTableGroupHeader.h"
#import "YLButtonView.h"

@interface YLHotCarView () <YLTableGroupHeaderDelegate>

@end

@implementation YLHotCarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CGRect goupHeaderRect = CGRectMake(0, 0, YLScreenWidth, 44);
    YLTableGroupHeader *groupHeader = [[YLTableGroupHeader alloc] initWithFrame:goupHeaderRect image:@"热门二手车" title:@"热门二手车" detailTitle:@"查看更多" arrowImage:@"更多"];
//    groupHeader.labelBlock = ^() {
//        if (self.moreBlock) {
//            self.moreBlock();
//        }
//    };
    groupHeader.delegate = self;
    [self addSubview:groupHeader];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(groupHeader.frame), YLScreenWidth, 0.5)];
    line1.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line1];
    
    NSArray *btnTitles = [NSArray arrayWithObjects:@"5万以下", @"5-10万", @"10-15万", @"15万以上", @"哈弗", @"丰田",@"大众", @"本田", @"力帆", @"日产", @"雪佛兰", @"现代", nil];
    CGRect buttonRect = CGRectMake(0, CGRectGetMaxY(line1.frame), YLScreenWidth, 99);
    YLButtonView *buttonView = [[YLButtonView alloc] initWithFrame:buttonRect btnTitles:btnTitles];
    buttonView.tapClickBlock = ^(UILabel * _Nonnull label) {
        NSLog(@"%@",label.text);
        if (self.brandBlock) {
            self.brandBlock(label.text);
        }
    };
    [self addSubview:buttonView];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(buttonView.frame), YLScreenWidth, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

- (void)pushBuyControl {
    if (self.moreBlock) {
        self.moreBlock();
    }
}
@end

//
//  YLButtonView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLButtonView.h"

@interface YLButtonView ()

@property (nonatomic, strong) NSString *selectBtnTitle;

@end

@implementation YLButtonView

- (instancetype)initWithFrame:(CGRect)frame btnTitles:(NSArray *)btnTitles {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        float width = frame.size.width / 4;
        float height = frame.size.height / 3;
        for (int i = 0; i < btnTitles.count; i++) {
            int row = i / 4;
            int line = i % 4;
            UILabel *searchL = [[UILabel alloc] init];
            searchL.frame = CGRectMake(line * width, row * height, width, height);
            searchL.text = btnTitles[i];
            searchL.textAlignment = NSTextAlignmentCenter;
            searchL.font = [UIFont systemFontOfSize:14];
            searchL.textColor = YLColor(116.f, 116.f, 116.f);
            searchL.tag = 100 + i;
            searchL.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabelClick:)];
            [searchL addGestureRecognizer:tap];
            [self addSubview:searchL];
        }
    }
    return self;
}

- (void)tapLabelClick:(UITapGestureRecognizer *)tap {
    
    UILabel *label = (UILabel *)tap.view;
    if (self.tapClickBlock) {
        self.tapClickBlock(label);
    }
}

- (void)selectBtn:(UIButton *)sender {
    
//    NSLog(@"selectBtn:按钮被点击le");
    self.selectBtnTitle = sender.titleLabel.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectBtnTitle:)]) {
        [self.delegate selectBtnTitle:self.selectBtnTitle];
    }
}

@end

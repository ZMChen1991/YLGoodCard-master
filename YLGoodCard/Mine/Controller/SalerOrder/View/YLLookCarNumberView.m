//
//  YLLookCarNumberView.m
//  YLGoodCard
//
//  Created by lm on 2018/12/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLLookCarNumberView.h"

@interface YLLookCarNumberView ()

@property (nonatomic, strong) UILabel *tureNumberL;
@property (nonatomic, strong) UILabel *browseNumberL;

@end

@implementation YLLookCarNumberView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UILabel *tureNumberL = [[UILabel alloc] init];
    tureNumberL.textAlignment = NSTextAlignmentCenter;
    tureNumberL.font = [UIFont systemFontOfSize:14];
    [self addSubview:tureNumberL];
    self.tureNumberL = tureNumberL;
    
    UILabel *browseNumberL = [[UILabel alloc] init];
    browseNumberL.textAlignment = NSTextAlignmentCenter;
    browseNumberL.font = [UIFont systemFontOfSize:14];
    [self addSubview:browseNumberL];
    self.browseNumberL = browseNumberL;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.tureNumberL.frame = CGRectMake(0, 0, YLScreenWidth / 2, 20);
    self.browseNumberL.frame = CGRectMake(YLScreenWidth / 2, 0, YLScreenWidth / 2, 20);
}

- (void)setTureNumber:(NSString *)tureNumber {
    _tureNumber = tureNumber;
    NSString *string = [NSString stringWithFormat:@"预约看车(次):%@", tureNumber];
    NSAttributedString *str = [string changeString:tureNumber color:[UIColor redColor]];
    self.tureNumberL.attributedText = str;
}

- (void)setBrowseNumber:(NSString *)browseNumber {
    _browseNumber = browseNumber;
    NSString *string = [NSString stringWithFormat:@"浏览次数(次):%@", browseNumber];
    NSAttributedString *str = [string changeString:browseNumber color:[UIColor redColor]];
    self.browseNumberL.attributedText = str;
}

@end

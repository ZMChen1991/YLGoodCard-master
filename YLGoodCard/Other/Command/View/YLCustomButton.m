//
//  YLCustomButton.m
//  YLGoodCard
//
//  Created by lm on 2018/11/16.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCustomButton.h"

@interface YLCustomButton ()

@property (nonatomic, strong) UILabel *numberL;

@end

@implementation YLCustomButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:YLColor(155.f, 155.f, 155.f) forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        CGFloat numW = 20;
        UILabel *numberL = [[UILabel alloc] initWithFrame:CGRectMake(3 * numW - 8, 10, numW, numW)];
        numberL.font = [UIFont systemFontOfSize:12];
        numberL.textAlignment = NSTextAlignmentCenter;
        [numberL setTextColor:[UIColor whiteColor]];
        numberL.backgroundColor = [UIColor redColor];
        numberL.layer.cornerRadius = numW / 2;
        numberL.layer.masksToBounds = YES;
        numberL.hidden = YES;
        [self addSubview:numberL];
        self.numberL = numberL;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height * 0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    CGRect rect = CGRectMake(titleX, titleY, titleW, titleH);
    return rect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat imgX = contentRect.size.width/3;
    CGFloat imgY = 15;
    CGFloat imgW = contentRect.size.width/3;
    CGFloat imgH = contentRect.size.height * 0.4;
    CGRect rect = CGRectMake(imgX, imgY, imgW, imgH);
    return rect;
}

- (void)setNumbers:(NSString *)numbers {
    _numbers = numbers;
    NSLog(@"numbers:%@", numbers);
    if ([numbers isEqualToString:@"0"]) {
        self.numberL.hidden = YES;
    } else {
        self.numberL.text = numbers;
        self.numberL.hidden = NO;
    }
    
}

@end

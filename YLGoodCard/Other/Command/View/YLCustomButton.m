//
//  YLCustomButton.m
//  YLGoodCard
//
//  Created by lm on 2018/11/16.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCustomButton.h"

@implementation YLCustomButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:YLColor(155.f, 155.f, 155.f) forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
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

@end

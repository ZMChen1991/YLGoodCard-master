//
//  YLCondition.m
//  YLGoodCard
//
//  Created by lm on 2018/11/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

//    // 添加边框--描边
//    CGColorSpaceRef colorSpace1 = CGColorSpaceCreateDeviceRGB();
//    CGColorRef borderColorRef1 = CGColorCreate(colorSpace1, (CGFloat[]){255.0/255.0, 255.0/255.0, 255.0/255.0, 1});
//    [self.layer setBorderColor:borderColorRef1];
//    [self.layer setBorderWidth:2.0];

#import "YLCondition.h"

@implementation YLCondition

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setType:(YLConditionType)type {
    
    _type = type;
    switch (type) {
        case YLConditionTypeBlue: // 蓝底白字
            self.backgroundColor = YLColor(8.f, 169.f, 255.f);
            [self setTitleColor:YLColor(255.0, 255.0, 255.0) forState:UIControlStateNormal];
            self.layer.borderWidth = 0.6;
            self.layer.borderColor = YLColor(8.f, 169.f, 255.f).CGColor;
            break;
        case YLConditionTypeWhite: // 白底蓝字
            self.backgroundColor = [UIColor whiteColor];
            [self setTitleColor:YLColor(8.f, 169.f, 255.f) forState:UIControlStateNormal];
            self.layer.borderWidth = 0.6;
            self.layer.borderColor = YLColor(8.f, 169.f, 255.f).CGColor;
            break;
        case YLConditionTypeGray: // 灰底白字
            self.backgroundColor = YLColor(213.f, 213.f, 213.f);
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.layer.borderWidth = 0.6;
            self.layer.borderColor = YLColor(213.f, 213.f, 213.f).CGColor;
            break;
        default:
            break;
    }
}
@end

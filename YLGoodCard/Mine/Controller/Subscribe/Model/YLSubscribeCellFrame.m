//
//  YLSubscribeCellFrame.m
//  YLGoodCard
//
//  Created by lm on 2019/1/16.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLSubscribeCellFrame.h"

#define YLTopSpace 10

@implementation YLSubscribeCellFrame

- (void)setModel:(YLSubscribeDetailModel *)model {
    _model = model;
    
    self.iconF = CGRectMake(YLLeftMargin, YLTopSpace, 120, 86);
    
    CGFloat titleX = CGRectGetMaxX(self.iconF) + YLLeftMargin;
    CGFloat titleW = YLScreenWidth - 120 - 2 * YLLeftMargin - YLTopSpace;
    CGFloat priceW = [[self stringToNumber:model.price] getSizeWithFont:[UIFont systemFontOfSize:18]].width + 10;
    self.titleF = CGRectMake(titleX, YLTopSpace, titleW, 34);
    self.courseF = CGRectMake(titleX, CGRectGetMaxY(self.titleF) + 5, titleW, 17);
    self.priceF = CGRectMake(titleX, CGRectGetMaxY(self.courseF) + 5, priceW, 25);
    self.originalPriceF = CGRectMake(CGRectGetMaxX(self.priceF), CGRectGetMaxY(self.courseF) + 9, YLScreenWidth - CGRectGetMaxX(self.priceF) - YLTopSpace, 17);
    self.lineF = CGRectMake(0, CGRectGetMaxY(self.iconF) - 1 + YLLeftMargin, YLScreenWidth, 1);
    self.cellHeight = CGRectGetMaxY(self.lineF);
}

- (NSString *)stringToNumber:(NSString *)number {
    
    CGFloat count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}

@end

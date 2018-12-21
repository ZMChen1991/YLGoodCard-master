//
//  YLSubCellModel.m
//  YLGoodCard
//
//  Created by lm on 2018/11/29.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSubCellModel.h"

#define YLTopSpace 12

@implementation YLSubCellModel

- (void)setLookCarModel:(YLLookCarModel *)lookCarModel {
    
    _lookCarModel = lookCarModel;
    CGFloat width = YLScreenWidth;
    self.iconF = CGRectMake(YLLeftMargin, YLTopSpace, 120, 86);
    CGFloat titleX = CGRectGetMaxX(self.iconF) + YLLeftMargin;
    CGFloat titleW = width - 120 - 2 * YLLeftMargin - YLTopSpace;
    CGFloat priceW = [[self stringToNumber:lookCarModel.detail.price] getSizeWithFont:[UIFont systemFontOfSize:18]].width + 10;
    self.titleF = CGRectMake(titleX, YLTopSpace, titleW, 34);
//    self.courseF = CGRectMake(titleX, CGRectGetMaxY(self.titleF) + 5, titleW, 17);
    self.lookCarTimeF = CGRectMake(titleX, CGRectGetMaxY(self.titleF)+5, titleW, 17);
    self.priceF = CGRectMake(titleX, CGRectGetMaxY(self.lookCarTimeF) + 5, priceW, 25);
    self.originalPriceF = CGRectMake(CGRectGetMaxX(self.priceF), CGRectGetMaxY(self.lookCarTimeF) + 9, width - CGRectGetMaxX(self.priceF) - YLTopSpace, 17);
    self.lineF = CGRectMake(0, CGRectGetMaxY(self.iconF)-1 + YLLeftMargin, width, 1);
    self.cellHeight = CGRectGetMaxY(self.lineF);
}

- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}

@end

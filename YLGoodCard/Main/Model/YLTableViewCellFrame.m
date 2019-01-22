//
//  YLTableViewCellFrame.m
//  YLGoodCard
//
//  Created by lm on 2018/12/20.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLTableViewCellFrame.h"

#define YLLeftSpace 15
#define YLTopSpace 12

@implementation YLTableViewCellFrame

- (void)setModel:(YLTableViewModel *)model {
    _model = model;
    
    self.displayImgF = CGRectMake(YLLeftMargin, YLTopSpace, 120, 86);
    CGFloat courseW = YLScreenWidth - 120 - 2 * YLLeftMargin - YLTopSpace;
    CGFloat titleX = CGRectGetMaxX(self.displayImgF) + YLLeftMargin;
    CGFloat titleW = YLScreenWidth - CGRectGetMaxX(self.displayImgF) - 2 * YLLeftMargin;
    NSString *price = [self stringToNumber:model.price];
    CGFloat priceW = [price getSizeWithFont:[UIFont systemFontOfSize:18]].width + 10;
    self.titleF = CGRectMake(titleX, YLTopSpace, titleW, 34);
    self.courseF = CGRectMake(titleX, CGRectGetMaxY(self.titleF) + 5, courseW, 17);
    self.priceF = CGRectMake(titleX, CGRectGetMaxY(self.courseF) + 5, priceW, 25);
    self.originalPriceF = CGRectMake(CGRectGetMaxX(self.priceF), CGRectGetMaxY(self.courseF) + 5, YLScreenWidth - CGRectGetMaxX(self.priceF) - 15 , 25);
    self.lineF = CGRectMake(0, CGRectGetMaxY(self.displayImgF) + YLTopMargin, YLScreenWidth, 1);
}

- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}

@end

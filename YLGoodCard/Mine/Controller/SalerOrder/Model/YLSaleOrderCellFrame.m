//
//  YLSaleOrderCellFrame.m
//  YLGoodCard
//
//  Created by lm on 2018/12/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSaleOrderCellFrame.h"

#define YLTopSpace 10

@implementation YLSaleOrderCellFrame

- (void)setModel:(YLSaleOrderModel *)model {
    
    _model = model;
    
    CGFloat width = YLScreenWidth;
    self.iconF = CGRectMake(YLLeftMargin, YLTopSpace, 120, 86);
    
    float titleX = CGRectGetMaxX(self.iconF) + YLLeftMargin;
    float titleW = width - 120 - 2 * YLLeftMargin - YLTopSpace;
    self.titleF = CGRectMake(titleX, YLTopSpace, titleW, 34);
    
    self.courseF = CGRectMake(titleX, CGRectGetMaxY(self.titleF) + 5, titleW, 17);
    
    self.lookCarTimeF = CGRectMake(titleX, CGRectGetMaxY(self.titleF)+5, titleW, 17);
    
    self.priceF = CGRectMake(titleX, CGRectGetMaxY(self.lookCarTimeF) + 5, titleW/3, 25);
    
    self.originalPriceF = CGRectMake(CGRectGetMaxX(self.priceF), CGRectGetMaxY(self.lookCarTimeF) + 9, width - CGRectGetMaxX(self.priceF) - YLTopSpace, 17);
    
    //    self.lookCarTimeF = CGRectMake(titleX, CGRectGetMaxY(self.priceF), titleW, 17);
    
    self.lineF = CGRectMake(0, CGRectGetMaxY(self.iconF)-1 + YLLeftMargin, width, 1);
    
    self.cellHeight = CGRectGetMaxY(self.lineF);
    
}

@end

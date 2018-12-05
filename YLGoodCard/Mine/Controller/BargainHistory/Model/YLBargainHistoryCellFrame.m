//
//  YLBargainHistoryCellFrame.m
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBargainHistoryCellFrame.h"

#define YLTopSpace 10

@implementation YLBargainHistoryCellFrame

- (void)setModel:(YLBargainHistoryModel *)model {
    _model = model;
    
    self.iconF = CGRectMake(YLLeftMargin, YLTopSpace, 120, 86);
    
    float titleX = CGRectGetMaxX(self.iconF) + YLLeftMargin;
    float titleW = YLScreenWidth - 120 - 2 * YLLeftMargin - YLTopSpace;
    self.titleF = CGRectMake(titleX, YLTopSpace, titleW, 34);
    
    self.courseF = CGRectMake(titleX, CGRectGetMaxY(self.titleF) + 5, titleW, 17);
    
    self.priceF = CGRectMake(titleX, CGRectGetMaxY(self.courseF) + 5, titleW/3, 25);
    
    self.originalPriceF = CGRectMake(CGRectGetMaxX(self.priceF), CGRectGetMaxY(self.courseF) + 9, YLScreenWidth - CGRectGetMaxX(self.priceF) - YLTopSpace, 17);
    
    self.bargainNumberF = CGRectMake(YLScreenWidth - 36 - 15, 40, 36, 36);
    
    self.lineF = CGRectMake(0, CGRectGetMaxY(self.iconF)-1 + YLLeftMargin, YLScreenWidth, 1);
    
    self.cellHeight = CGRectGetMaxY(self.lineF);
}

@end

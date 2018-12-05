//
//  YLBuyCellFrame.m
//  YLGoodCard
//
//  Created by lm on 2018/11/23.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBuyCellFrame.h"

#define YLLeftSpace 15
#define YLTopSpace 12

@implementation YLBuyCellFrame

- (void)setModel:(YLTableViewModel *)model {
    
    _model = model;
    float width = YLScreenWidth;
    if (model.isLargeImage) {
        self.iconF = CGRectMake(YLLeftSpace, YLLeftSpace, width - 2 * YLLeftSpace, 228);
        self.titleF = CGRectMake(YLLeftSpace, CGRectGetMaxY(self.iconF)+YLLeftSpace, width - 2* YLLeftSpace, 17);
        self.courseF = CGRectMake(YLLeftSpace, CGRectGetMaxY(self.titleF) + 5, width - 2* YLLeftSpace, 17);
        self.priceF = CGRectMake(YLLeftSpace, CGRectGetMaxY(self.courseF) + 5, (width - 2* YLLeftSpace) / 2, 25);
        self.originalPriceF = CGRectMake(CGRectGetMaxX(self.priceF) + 5, CGRectGetMaxY(self.courseF) + 5, (width - 2* YLLeftSpace) / 2, 25);
        self.lineF = CGRectMake(0, CGRectGetMaxY(self.priceF)+YLTopSpace-1, width, 1);
    } else {
        self.iconF = CGRectMake(YLLeftSpace, YLTopSpace, 120, 86);
        float titleX = CGRectGetMaxX(self.iconF) + YLLeftSpace;
        float titleW = width - 120 - 2 * YLLeftSpace - YLTopSpace;
        self.titleF = CGRectMake(titleX, YLTopSpace, titleW, 34);
        self.courseF = CGRectMake(titleX, CGRectGetMaxY(self.titleF) + 5, titleW, 17);
        self.priceF = CGRectMake(titleX, CGRectGetMaxY(self.courseF) + 5, titleW/3, 25);
        self.lineF = CGRectMake(0, CGRectGetMaxY(self.iconF)+YLTopSpace-1, width, 1);
        switch (self.model.cellStatus) {
            case YLTableViewCellStatusSold:
                self.originalPriceF = CGRectMake(CGRectGetMaxX(self.priceF), CGRectGetMaxY(self.courseF) + 5, titleW / 2, 25);
                break;
            case YLTableViewCellStatusBargain:
                self.originalPriceF = CGRectMake(CGRectGetMaxX(self.priceF), CGRectGetMaxY(self.courseF) + 5, titleW / 2, 25);
                float bargainX = width - 36 - YLLeftSpace;
                float bargainY = 110 - 36 - YLLeftSpace;
                self.bargainF = CGRectMake(bargainX, bargainY, 36, 36);
                break;
            case YLTableViewCellStatusDownPrice:
                self.downIconF = CGRectMake(CGRectGetMaxX(self.priceF) + 5, CGRectGetMaxY(self.courseF) + 13, 14, 14);
                self.downTitleF = CGRectMake(CGRectGetMaxX(self.downIconF) + 5, CGRectGetMaxY(self.courseF) + 10, titleW / 2, 17);
                break;
            default:
                break;
        }
    }
    self.cellHeight = CGRectGetMaxY(self.lineF);
//    NSLog(@"%f", self.cellHeight);
}

@end

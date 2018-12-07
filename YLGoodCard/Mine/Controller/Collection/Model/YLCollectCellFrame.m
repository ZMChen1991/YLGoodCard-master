//
//  YLCollectCellFrame.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCollectCellFrame.h"

#define YLTopSpace 12

@implementation YLCollectCellFrame

- (void)setCollectionModel:(YLCollectionModel *)collectionModel {
    _collectionModel = collectionModel;
    
    CGFloat width = YLScreenWidth;
    self.iconF = CGRectMake(YLLeftMargin, YLTopSpace, 120, 86);
    float titleX = CGRectGetMaxX(self.iconF) + YLLeftMargin;
    float titleW = width - 120 - 2 * YLLeftMargin - YLTopSpace;
    self.titleF = CGRectMake(titleX, YLTopSpace, titleW, 34);
    self.courseF = CGRectMake(titleX, CGRectGetMaxY(self.titleF) + 5, titleW, 17);
    self.priceF = CGRectMake(titleX, CGRectGetMaxY(self.courseF) + 5, titleW/3, 25);
    self.originalPriceF = CGRectMake(CGRectGetMaxX(self.priceF), CGRectGetMaxY(self.courseF) + 9, width - CGRectGetMaxX(self.priceF) - YLTopSpace, 17);
    self.lineF = CGRectMake(0, CGRectGetMaxY(self.iconF)-1 + YLLeftMargin, width, 1);
    self.cellHeight = CGRectGetMaxY(self.lineF);
    
}

@end

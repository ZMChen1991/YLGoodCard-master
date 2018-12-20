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
    
    self.displayImgF = CGRectMake(YLLeftSpace, YLTopSpace, 120, 86);
    CGFloat courseW = YLScreenWidth - 120 - 2 * YLLeftSpace - YLTopSpace;
    CGFloat titleX = CGRectGetMaxX(self.displayImgF) + YLLeftSpace;
    CGFloat titleW = [model.title getSizeWithFont:[UIFont systemFontOfSize:14]].width + 10;
    self.titleF = CGRectMake(titleX, YLTopSpace, titleW, 34);
    self.courseF = CGRectMake(titleX, CGRectGetMaxY(self.titleF) + 5, courseW, 17);
    self.priceF = CGRectMake(titleX, CGRectGetMaxY(self.courseF) + 5, titleW/2, 25);
    self.originalPrice = CGRectMake(CGRectGetMaxX(self.priceF), CGRectGetMaxY(self.courseF) + 5, titleW / 2, 25);
    
}

@end

//
//  YLBargainDetailCellFrame.m
//  YLGoodCard
//
//  Created by lm on 2018/12/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBargainDetailCellFrame.h"

@implementation YLBargainDetailCellFrame

- (void)setModel:(YLBargainDetailModel *)model {
    _model = model;
    
    CGFloat timeW = (YLScreenWidth - 2 * YLLeftMargin) / 2;
    if (model.isBuyer) { // 买家
        if ([model.mark isEqualToString:@"2"]) {
            if ([model.status isEqualToString:@"1"]) {
                self.titleF = CGRectMake(YLLeftMargin, YLLeftMargin, YLScreenWidth - 2 * YLLeftMargin, 20);
                self.timeF = CGRectMake(YLLeftMargin, CGRectGetMaxY(self.titleF) + 5, timeW, 20);
                self.lineF = CGRectMake(0, CGRectGetMaxY(self.timeF) + YLLeftMargin, YLScreenWidth, 1);
                self.dickerF = CGRectMake(YLScreenWidth - 15 - 60 - 10 - 60, CGRectGetMaxY(self.titleF) + 5, 60, 30);
                self.acceptF = CGRectMake(YLScreenWidth - 15 - 60, CGRectGetMaxY(self.titleF) + 5, 60, 30);
                self.cellHeight = CGRectGetMaxY(self.lineF);
            } else {
                self.titleF = CGRectMake(YLLeftMargin, YLLeftMargin, YLScreenWidth - 2 * YLLeftMargin, 20);
                self.timeF = CGRectMake(YLLeftMargin, CGRectGetMaxY(self.titleF) + 5, timeW, 20);
                self.lineF = CGRectMake(0, CGRectGetMaxY(self.timeF) + YLLeftMargin, YLScreenWidth, 1);
                self.cellHeight = CGRectGetMaxY(self.lineF);
            }
        } else {
            self.titleF = CGRectMake(YLLeftMargin, YLLeftMargin, YLScreenWidth - 2 * YLLeftMargin, 20);
            self.timeF = CGRectMake(YLLeftMargin, CGRectGetMaxY(self.titleF) + 5, timeW, 20);
            self.lineF = CGRectMake(0, CGRectGetMaxY(self.timeF) + YLLeftMargin, YLScreenWidth, 1);
            self.cellHeight = CGRectGetMaxY(self.lineF);
        }
    } else { // 卖家
        if ([model.mark isEqualToString:@"1"]) {
            if ([model.status isEqualToString:@"1"]) {
                self.titleF = CGRectMake(YLLeftMargin, YLLeftMargin, YLScreenWidth - 2 * YLLeftMargin, 20);
                self.timeF = CGRectMake(YLLeftMargin, CGRectGetMaxY(self.titleF) + 5, timeW, 20);
                self.lineF = CGRectMake(0, CGRectGetMaxY(self.timeF) + YLLeftMargin, YLScreenWidth, 1);
                self.dickerF = CGRectMake(YLScreenWidth - 15 - 60 - 10 - 60, CGRectGetMaxY(self.titleF) + 5, 60, 30);
                self.acceptF = CGRectMake(YLScreenWidth - 15 - 60, CGRectGetMaxY(self.titleF) + 5, 60, 30);
                self.cellHeight = CGRectGetMaxY(self.lineF);
            } else {
                self.titleF = CGRectMake(YLLeftMargin, YLLeftMargin, YLScreenWidth - 2 * YLLeftMargin, 20);
                self.timeF = CGRectMake(YLLeftMargin, CGRectGetMaxY(self.titleF) + 5, timeW, 20);
                self.lineF = CGRectMake(0, CGRectGetMaxY(self.timeF) + YLLeftMargin, YLScreenWidth, 1);
                self.cellHeight = CGRectGetMaxY(self.lineF);
            }
        } else {
            self.titleF = CGRectMake(YLLeftMargin, YLLeftMargin, YLScreenWidth - 2 * YLLeftMargin, 20);
            self.timeF = CGRectMake(YLLeftMargin, CGRectGetMaxY(self.titleF) + 5, timeW, 20);
            self.lineF = CGRectMake(0, CGRectGetMaxY(self.timeF) + YLLeftMargin, YLScreenWidth, 1);
            self.cellHeight = CGRectGetMaxY(self.lineF);
        }
    }
}

@end

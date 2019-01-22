//
//  YLDetectCenterCellFrame.m
//  YLGoodCard
//
//  Created by lm on 2019/1/21.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLDetectCenterCellFrame.h"

@implementation YLDetectCenterCellFrame

- (void)setModel:(YLDetectCenterModel *)model {
    _model = model;
    
    CGFloat labelW = YLScreenWidth - 2 * YLLeftMargin;
    CGFloat labelH = 22;
    self.centerF = CGRectMake(YLLeftMargin, YLLeftMargin, labelW, labelH);
    NSString *address = [NSString stringWithFormat:@"地址:%@", model.address];
    CGSize addressSize = [address getSizeWithFont:[UIFont systemFontOfSize:14]];
    CGFloat addressH = 20.0f;
    CGFloat height = 20.0f;
    if (addressSize.width > labelW) {
        addressH = 40.0f;
    }
    self.addressF = CGRectMake(YLLeftMargin, CGRectGetMaxY(self.centerF) + 5, labelW, addressH);
    self.telephoneF = CGRectMake(YLLeftMargin, CGRectGetMaxY(self.addressF) + 5, labelW, height);
    self.lineF = CGRectMake(0, CGRectGetMaxY(self.telephoneF) + YLLeftMargin, YLScreenWidth, 1);
    self.cellHeight = CGRectGetMaxY(self.lineF);
}

@end

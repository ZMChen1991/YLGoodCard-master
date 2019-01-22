//
//  YLDetectCenterCellFrame.h
//  YLGoodCard
//
//  Created by lm on 2019/1/21.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLDetectCenterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLDetectCenterCellFrame : NSObject

@property (nonatomic, strong) YLDetectCenterModel *model;
@property (nonatomic, assign) CGRect centerF;
@property (nonatomic, assign) CGRect addressF;
@property (nonatomic, assign) CGRect telephoneF;
@property (nonatomic, assign) CGRect lineF;
@property (nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END

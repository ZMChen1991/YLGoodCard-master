//
//  YLReservationView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLDetectCenterModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReserVationBlock)(void);

@interface YLReservationView : UIView

@property (nonatomic, strong) YLDetectCenterModel *model;
@property (nonatomic, strong) NSString *checkOut;
@property (nonatomic, copy) ReserVationBlock reserVationBlock;

@end

NS_ASSUME_NONNULL_END

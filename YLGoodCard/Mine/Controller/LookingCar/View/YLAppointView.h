//
//  YLAppointView.h
//  YLGoodCard
//
//  Created by lm on 2018/12/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLDetectCenterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLAppointView : UIView

@property (nonatomic, strong) YLDetectCenterModel *model;
@property (nonatomic, strong) NSString *time;

@end

NS_ASSUME_NONNULL_END

//
//  YLBlemishModel.h
//  YLGoodCard
//
//  Created by lm on 2018/12/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLBlemishModel : NSObject

@property (nonatomic, assign) NSInteger sortNo;
@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *vehicleId;
@property (nonatomic, strong) NSString *remarks;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, strong) NSString *group;
@property (nonatomic, strong) NSString *updateAt;

@end

NS_ASSUME_NONNULL_END

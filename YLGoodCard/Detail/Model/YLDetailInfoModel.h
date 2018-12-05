//
//  YLDetailInfoModel.h
//  YLGoodCard
//
//  Created by lm on 2018/11/20.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLDetailInfoModel : NSObject

@property (nonatomic, strong) NSString *licenseTime;//上牌时间
@property (nonatomic, strong) NSString *commercialInsurance;//商业险
@property (nonatomic, strong) NSString *annualInspection; // 年检
@property (nonatomic, strong) NSString *course;//里程
@property (nonatomic, strong) NSString *emission;//排放量
@property (nonatomic, strong) NSString *emissionStandard;//排放标准
@property (nonatomic, strong) NSString *location;//车牌所在地
@property (nonatomic, strong) NSString *meetingPlace;//看车地点
@property (nonatomic, strong) NSString *gearbox;//变速箱
@property (nonatomic, strong) NSString *transfer;//过户次数
@property (nonatomic, strong) NSString *trafficInsurance;//交强险

@end

NS_ASSUME_NONNULL_END

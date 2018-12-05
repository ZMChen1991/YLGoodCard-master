//
//  YLSearchParamModel.h
//  YLGoodCard
//
//  Created by lm on 2018/11/22.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

// 条件搜索的属性

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface YLSearchParamModel : NSObject

YLSingletonH

@property (nonatomic, strong) NSString *carID; // 车辆ID
@property (nonatomic, strong) NSString *title;// 标题
@property (nonatomic, strong) NSString *brand;// 品牌
@property (nonatomic, strong) NSString *series;// 车系
@property (nonatomic, strong) NSString *price;// 价格
@property (nonatomic, strong) NSString *bodyStructure;// 车型
@property (nonatomic, strong) NSString *islocation;// 是否本地
@property (nonatomic, strong) NSString *gearbox;// 变速箱
@property (nonatomic, strong) NSString *vehicleAge;// 车龄
@property (nonatomic, strong) NSString *course;//里程
@property (nonatomic, strong) NSString *emission;//排放量
@property (nonatomic, strong) NSString *emissionStandard;// 排放标准
@property (nonatomic, strong) NSString *color;// 颜色
@property (nonatomic, strong) NSString *seatsNum;// 座位数
@property (nonatomic, strong) NSString *fuelForm;// 燃油方式
@property (nonatomic, strong) NSString *country;// 国别
@property (nonatomic, strong) NSString *panoramicSunroof;// 全景天窗
@property (nonatomic, strong) NSString *stabilityControl;// 车身稳定控制
@property (nonatomic, strong) NSString *reverseVideo;// 倒车影像系统
@property (nonatomic, strong) NSString *genuineLeather;// 真皮、仿皮座椅
@property (nonatomic, strong) NSString *keylessEntrySystem;// 无钥匙进入
@property (nonatomic, strong) NSString *childSeatInterface;// 儿童座椅接口
@property (nonatomic, strong) NSString *parkingRadar;// 倒车雷达
@property (nonatomic, strong) NSString *gps;// 导航
@property (nonatomic, strong) NSString *sort;// 排序条件 1：最新上架，2：价格最低，3价格最高，4：车辆最短，5：里程最小



@end

NS_ASSUME_NONNULL_END

//
//  YLTableViewModel.h
//  YLYouka
//
//  Created by lm on 2018/11/14.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//
//typedef NS_ENUM(NSInteger, YLTableViewCellType) {
//    YLTableViewCellTypeSamllImage,
//    YLTableViewCellTypeLargeImage,
//};

typedef NS_ENUM(NSInteger, YLTableViewCellStatus) {
    YLTableViewCellStatusSold,
    YLTableViewCellStatusBargain,
    YLTableViewCellStatusDownPrice,
};

@interface YLTableViewModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString *carID;
@property (nonatomic, strong) NSString *displayImg;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *course;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *originalPrice;
@property (nonatomic, strong) NSString *downPrice;
@property (nonatomic, strong) NSString *bargain;
@property (nonatomic, strong) NSString *status;

@property (nonatomic, assign) YLTableViewCellStatus cellStatus;
@property (nonatomic, assign) BOOL isLargeImage;

@end

NS_ASSUME_NONNULL_END

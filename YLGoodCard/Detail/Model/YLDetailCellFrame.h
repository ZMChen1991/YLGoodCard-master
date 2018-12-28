//
//  YLDetailCellFrame.h
//  YLGoodCard
//
//  Created by lm on 2018/12/28.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YLDetailReportModel.h"
#import "YLCarInformationModel.h"
#import "YLDetailInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLDetailCellFrame : NSObject

@property (nonatomic, strong) YLDetailReportModel *reportModel;
@property (nonatomic, strong) YLCarInformationModel *carInfomationModel;
@property (nonatomic, strong) YLDetailInfoModel *infoModel;

@property (nonatomic, assign) CGFloat reportCellHeight;
@property (nonatomic, assign) CGFloat carInfomationCellHeight;
@property (nonatomic, assign) CGFloat infoCellHeight;



@end

NS_ASSUME_NONNULL_END

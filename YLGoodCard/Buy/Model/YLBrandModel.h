//
//  YLBrandModel.h
//  YLGoodCard
//
//  Created by lm on 2018/11/16.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBaseTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLBrandModel : YLBaseTool <NSCoding>

@property (nonatomic, strong) NSString *brand;// 品牌
@property (nonatomic, strong) NSString *brandId;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *initialLetter;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *ID;

@end

NS_ASSUME_NONNULL_END

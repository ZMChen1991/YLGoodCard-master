//
//  YLDetectCenterModel.h
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLDetectCenterModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) BOOL status;

@end

NS_ASSUME_NONNULL_END
